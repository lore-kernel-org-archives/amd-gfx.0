Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747BBC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 09:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2373320717
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 09:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u/a9BIwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2373320717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D366189973;
	Tue, 17 Dec 2019 09:10:19 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700070.outbound.protection.outlook.com [40.107.70.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DF689973
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 09:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7+ANsC3dDRPhxa8DEA43Whx3lD/HbtKdFKXQOrgTEQmd1Lpb+5dFLdRNpT+BQ/tzc1ZRcVK8C6CFxtDLTHlnctG6WOyigSd1Z6cyQAHhEMfJguVWoUD6kw/lc64EJfG9TihM6WlGM7kdUqicnTK37LGWX3oc1Y1jTel0bWFTx0tODO31l5llD7xBeiX2Nw/W9cJHfyGHl9z2IHRjO7ljEQbG9gpKRjqpdR57a3/vo8N3kRWf3gKBmvDjzHZ3UeQytr2zMGqU+x2gttEfZVw8K0Z/vtXM4oxnWPYyWrLx9+BjjUeSLH8HGTkNNh9WtTSfruWUgTQf65dKXdpZXAKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj40nTxM0KzH/aZgXYZKB43Gw0zIwWD66MiprJcpBnk=;
 b=S6FWQfAvKzoMjE+aUZ9i/DA8I9KpYH5ZhzKPxKxcq8KqGygtbxXLJ6EU0J+273XlcVg8vnpJMA++JyguCX7Ja+x2g1+McNv7E/nMKgexheI7Oqm+0MHGaQf+nkF0zeqZ4oM5dZnRKpQpdQ6txK97qbrpcrpM+hbXc6MzKy9LDSvAp54ewaQ5ENEtNNzE2wu8k5eRu1FFB7H7PXaCXllulD5uRh/8WYd0vbV5Lj6NiM5zLiJHaMh4YrpJAMMspMm0+ndvbtzL7afzoTOnRHOsa4/Z5Fa+kMg3KNLlhn5Guun17CXZvNtyxHmGShiJLn+Zbnohfe7hXx2lougPj9WcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pj40nTxM0KzH/aZgXYZKB43Gw0zIwWD66MiprJcpBnk=;
 b=u/a9BIwiagiLrlkGaBUBT9LSfQ2XTCrYAvtvMB8OaqE2hB2B2mSNZOvWKGumBhMsAGpGRWiX1GRXZa3roHJ5nVl/lWXwV4OMRO7Gd0sNDerxoTwNrK8x+RlbU8kMTOdeadO95hWz3gZQMWHvTRjZPrsEvtmmLp85ZawB0IUoafM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2776.namprd12.prod.outlook.com (20.177.124.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 09:10:16 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 09:10:15 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: John.Clements@amd.com, Hawking.Zhang@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: move umc offset to one new header file for
 Arcturus
Date: Tue, 17 Dec 2019 17:08:17 +0800
Message-Id: <20191217090817.12427-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ade0c2b-eb5a-4cb8-afb2-08d782d0ee13
X-MS-TrafficTypeDiagnostic: BYAPR12MB2776:|BYAPR12MB2776:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27762234743C569C31B05689F1500@BYAPR12MB2776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(478600001)(66476007)(4326008)(26005)(6512007)(44832011)(2616005)(316002)(8936002)(81166006)(81156014)(8676002)(5660300002)(66556008)(2906002)(6506007)(52116002)(19627235002)(36756003)(86362001)(66946007)(1076003)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2776;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQGpGcW1ERBx2skkkkPn/VloozxXuc1VBIeQEk8bMaGtNuhDGkVJdu5z1AYRtMCAP3z8c81DcYcmadqRR5HOknMmNwbZjNJTdgpRLXe3Df/nS82dnQBSDzuPWlRKixJyHCMh9SY+lr26G8Ga2ixhLKVw0VHJ1Srs3fq7MpTQ5zv5YOFyp8HjIJpAkOVz63y1sfHswmm55nQ6fhdrivLUrGeR2/1H6nYCb8VABX/9M8LWMdmqKKdg3zyJQH1hezIar73xjzjPgmbwOcrC/DPU6pz6jb9KgUVhlpnmv+fOdx1/yr+MT05ePOBI0VBt3EdCbt7GhPmaucS4ZbRkCUPmUbgK+7jRi2iMcxwm0PCigtczZhilEz1lT5sH5beWAV6NL/phYQFi1IAf19k8DT0wXxdZqmz2aLbdIGiz4/2lVGI3phkgQKP0osHPk5tQmioU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ade0c2b-eb5a-4cb8-afb2-08d782d0ee13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 09:10:15.8698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NfhE/dZQdN5Uh/687Vur4hOCQuJFaUC1oXp7zCiURbh/0xrls1xBokQFbvUVekOCGx02VWF/t6zXEwJZV/tGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2776
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 9686563c4c42 drm/amdgpu: Added RAS UMC error query support for Arcturus

Code refactor and no functional change.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c         | 17 +---------
 .../include/asic_reg/umc/umc_6_1_2_offset.h   | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 515eb50cd0f8..5093965dbc24 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -28,17 +28,10 @@
 #include "rsmu/rsmu_0_0_2_sh_mask.h"
 #include "umc/umc_6_1_1_offset.h"
 #include "umc/umc_6_1_1_sh_mask.h"
+#include "umc/umc_6_1_2_offset.h"
 
 #define smnMCA_UMC0_MCUMC_ADDRT0	0x50f10
 
-/* UMC 6_1_2 register offsets */
-#define mmUMCCH0_0_EccErrCntSel_ARCT                 0x0360
-#define mmUMCCH0_0_EccErrCntSel_ARCT_BASE_IDX        1
-#define mmUMCCH0_0_EccErrCnt_ARCT                    0x0361
-#define mmUMCCH0_0_EccErrCnt_ARCT_BASE_IDX           1
-#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT           0x03c2
-#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT_BASE_IDX  1
-
 /*
  * (addr / 256) * 8192, the higher 26 bits in ErrorAddr
  * is the index of 8KB block
@@ -105,7 +98,6 @@ static void umc_v6_1_query_correctable_error_count(struct amdgpu_device *adev,
 
 	if (adev->asic_type == CHIP_ARCTURUS) {
 		/* UMC 6_1_2 registers */
-
 		ecc_err_cnt_sel_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel_ARCT);
 		ecc_err_cnt_addr =
@@ -114,7 +106,6 @@ static void umc_v6_1_query_correctable_error_count(struct amdgpu_device *adev,
 			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);
 	} else {
 		/* UMC 6_1_1 registers */
-
 		ecc_err_cnt_sel_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel);
 		ecc_err_cnt_addr =
@@ -164,12 +155,10 @@ static void umc_v6_1_querry_uncorrectable_error_count(struct amdgpu_device *adev
 
 	if (adev->asic_type == CHIP_ARCTURUS) {
 		/* UMC 6_1_2 registers */
-
 		mc_umc_status_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);
 	} else {
 		/* UMC 6_1_1 registers */
-
 		mc_umc_status_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);
 	}
@@ -211,12 +200,10 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 
 	if (adev->asic_type == CHIP_ARCTURUS) {
 		/* UMC 6_1_2 registers */
-
 		mc_umc_status_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT);
 	} else {
 		/* UMC 6_1_1 registers */
-
 		mc_umc_status_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmMCA_UMC_UMC0_MCUMC_STATUST0);
 	}
@@ -282,14 +269,12 @@ static void umc_v6_1_err_cnt_init_per_channel(struct amdgpu_device *adev,
 
 	if (adev->asic_type == CHIP_ARCTURUS) {
 		/* UMC 6_1_2 registers */
-
 		ecc_err_cnt_sel_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel_ARCT);
 		ecc_err_cnt_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCnt_ARCT);
 	} else {
 		/* UMC 6_1_1 registers */
-
 		ecc_err_cnt_sel_addr =
 			SOC15_REG_OFFSET(UMC, 0, mmUMCCH0_0_EccErrCntSel);
 		ecc_err_cnt_addr =
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h
new file mode 100644
index 000000000000..3e79a8056556
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_1_2_offset.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2019  Advanced Micro Devices, Inc.
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
+#ifndef _umc_6_1_2_OFFSET_HEADER
+#define _umc_6_1_2_OFFSET_HEADER
+
+#define mmUMCCH0_0_EccErrCntSel_ARCT                                     0x0360
+#define mmUMCCH0_0_EccErrCntSel_ARCT_BASE_IDX                            1
+#define mmUMCCH0_0_EccErrCnt_ARCT                                        0x0361
+#define mmUMCCH0_0_EccErrCnt_ARCT_BASE_IDX                               1
+#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT                               0x03c2
+#define mmMCA_UMC_UMC0_MCUMC_STATUST0_ARCT_BASE_IDX                      1
+
+#endif
+
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
