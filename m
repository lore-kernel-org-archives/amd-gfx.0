Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0AC3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974CC20870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="euzHwt3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974CC20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6063F6EB1D;
	Wed,  4 Mar 2020 10:52:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC676EB1D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 10:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhpsXV4t6M/8O+ZbcxeoB0R5+u1zqwQXGB7y247cVlCCeQAuGHHtF5wPbWdOHaSItYqjBL/EWLVDckq/+A65ko5CZPnu8x8QcXVvC3veaKdDO9u2/uzNqkJ88tYw6/K2H3oTJl8L9fp//5Rwvb3EgSkrWVQApKt59Ofv9O/UFJymdynFqZW5vm0sbGJBa0m+ubHLSbfL3gHo1Wa5IhOscapMl1H+HXsOAdbQYipJG0tcRejTz1xkmKjJICc28M6f0ovkHGFPvi58h4WdbBmgEVI18jecnJ/mnsx1zfCKLQOiyKakOBuFcpn4znyFsCTfKx2RVL6e4DP5bqUBH7fAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRWvUGVI9n7J3PHYfb7B1WXdjsl9AwLVLhbS+kq7Qf8=;
 b=MrjSNwJkzyRRTRIcG308O78ElYZJX9b4aXGaErjF204rWjwS2VzDMKyTh+V+dIC7sdppx8Gt/y9h8uNXl6KPBZ/fyfFF6laASaSEvEgys4a6wCcPqR1LhT1/a3MOYQdbqVxfvg7bxnYb8iJ50UXBnQyUvFFhb06boFLuA1qh40iPuvEYYlKStAvSI3EWZNckRi+dGEoOhe+7mSD5O1XSbHDKJlNKk2G3+N/9eQALftOgB2JY2pfjC0fYddohbhPEdFBkinTymf2TRvK/AcAZdI4vP+sFy4ghLBRH1aef1kw0Iqc6V9C7H5Bx6zc5Jva6vTVIPp9zxTH4/5SCuyqS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRWvUGVI9n7J3PHYfb7B1WXdjsl9AwLVLhbS+kq7Qf8=;
 b=euzHwt3EV2C2o1ierULNs9Zb4xsJIh7hw6CAoTwrBXxnSHSxr/D7Dvusx22weWHQwcGRmKEH8k2n33XZbyHSgabbj0SwMyOweYfUDEPY2WTB3gtI6YhR0XZoW2t+qWoJ1TbOEj53pYfG4cYrv6q4W9K1E0Zsf2rzpUIdHZmpfnw=
Received: from BN8PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:ac::30)
 by BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 10:52:14 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::86) by BN8PR07CA0017.outlook.office365.com
 (2603:10b6:408:ac::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Wed, 4 Mar 2020 10:52:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 10:52:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:13 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:12 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 04:52:10 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Tao
 Zhou" <Tao.Zhou1@amd.com>, John Clements <John.Clements@amd.com>, Dennis Li
 <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: add xgmi ip headers
Date: Wed, 4 Mar 2020 18:51:59 +0800
Message-ID: <20200304105203.6660-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(428003)(199004)(189003)(70586007)(6636002)(5660300002)(2906002)(1076003)(186003)(36756003)(86362001)(110136005)(70206006)(426003)(81156014)(8936002)(356004)(2616005)(81166006)(8676002)(19627235002)(478600001)(336012)(26005)(6666004)(316002)(4326008)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR12MB3108; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb48a3b-fb63-4f7f-7221-08d7c02a18fa
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:
X-Microsoft-Antispam-PRVS: <BN8PR12MB310804ADE71A15BCB01EFE5BFCE50@BN8PR12MB3108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDcQr6rx53CZcG20S3YyejLqy9aKoDWpsWP5RhSIRzEibqFQ0FCAjvC0XSlwXUdVnaPRbnHCd68xBb8QEpQMNTuVr1mO5mINsJ3PICOuIFfRymJ+KDNrZGqlTQq+gVQ6J6U3J3FcSoKZtZMFOTrD2uX9XJ0N+VG+PqMBjs1zdVXQXW/dbeuobUppTJkV6o8vm3UKx9/8AnZa6wpGNYZqE7w0iv4utp5YrcJBupSQdzgCfevjWzYgYPOT+buOBH3pE+ylfOS+Ht5PJMShC+fFHWigZU4wjINc82OueSFd+0DqHKih4UyvaJBEqrTcN4Su9AUTxmOPjYRj2AtjSQ7GeTnT+K+4HR3Mqr9X0QqDwVMZ9hqbEsCT+J+yPM1p8f9zRX/+u5aI1oIWu3iUwDHhNCyKfAHPSdhfE4MpRnjqbhzc9xX5mX3/2LDG1cmS9wq9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 10:52:13.6000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb48a3b-fb63-4f7f-7221-08d7c02a18fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3108
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

add xgmi ip smn address and shift mask header files

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 .../asic_reg/xgmi/xgmi_4_0_0_sh_mask.h        | 69 +++++++++++++++++++
 .../include/asic_reg/xgmi/xgmi_4_0_0_smn.h    | 29 ++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_smn.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_sh_mask.h
new file mode 100644
index 000000000000..f37712f05b03
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_sh_mask.h
@@ -0,0 +1,69 @@
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
+#ifndef _xgmi_4_0_0_SH_MASK_HEADER
+#define _xgmi_4_0_0_SH_MASK_HEADER
+
+//PCS_GOPX16_PCS_ERROR_STATUS
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DataLossErr__SHIFT								0x0
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__TrainingErr__SHIFT								0x1
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__CRCErr__SHIFT								0x5
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__BERExceededErr__SHIFT							0x6
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__TxMetaDataErr__SHIFT								0x7
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReplayBufParityErr__SHIFT							0x8
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DataParityErr__SHIFT								0x9
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReplayFifoOverflowErr__SHIFT							0xa
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReplayFifoUnderflowErr__SHIFT						0xb
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ElasticFifoOverflowErr__SHIFT						0xc
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DeskewErr__SHIFT								0xd
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DataStartupLimitErr__SHIFT							0xf
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__FCInitTimeoutErr__SHIFT							0x10
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__RecoveryTimeoutErr__SHIFT							0x11
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReadySerialTimeoutErr__SHIFT							0x12
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReadySerialAttemptErr__SHIFT							0x13
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__RecoveryAttemptErr__SHIFT							0x14
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__RecoveryRelockAttemptErr__SHIFT						0x15
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ClearBERAccum__SHIFT								0x17
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__BERAccumulator__SHIFT							0x18
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DataLossErr_MASK								0x00000001L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__TrainingErr_MASK								0x00000002L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__CRCErr_MASK									0x00000020L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__BERExceededErr_MASK								0x00000040L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__TxMetaDataErr_MASK								0x00000080L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReplayBufParityErr_MASK							0x00000100L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DataParityErr_MASK								0x00000200L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReplayFifoOverflowErr_MASK							0x00000400L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReplayFifoUnderflowErr_MASK							0x00000800L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ElasticFifoOverflowErr_MASK							0x00001000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DeskewErr_MASK								0x00002000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__DataStartupLimitErr_MASK							0x00008000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__FCInitTimeoutErr_MASK							0x00010000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__RecoveryTimeoutErr_MASK							0x00020000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReadySerialTimeoutErr_MASK							0x00040000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ReadySerialAttemptErr_MASK							0x00080000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__RecoveryAttemptErr_MASK							0x00100000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__RecoveryRelockAttemptErr_MASK						0x00200000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__ClearBERAccum_MASK								0x00800000L
+#define	XGMI0_PCS_GOPX16_PCS_ERROR_STATUS__BERAccumulator_MASK								0xFF000000L
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_smn.h b/drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_smn.h
new file mode 100644
index 000000000000..6ccbac4ce87e
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/xgmi/xgmi_4_0_0_smn.h
@@ -0,0 +1,29 @@
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
+#ifndef _xgmi_4_0_0_SMN_HEADER
+#define _xgmi_4_0_0_SMN_HEADER
+
+#define	smnXGMI0_PCS_GOPX16_PCS_ERROR_STATUS				0x11af0210
+
+#endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
