Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26511C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED04B20870
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H6lPTR7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED04B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B146F6EB1E;
	Wed,  4 Mar 2020 10:52:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6456F6EB1E
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 10:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7CJUWCO5B4X1cD0sUIuMzNxOs7PO9JETI59qjTdRNrIpVJqtyCwmNdn3I07ZvFJRgPN+16T2nZQxiIhQ5AgJH/XhKvRwCkPxRf6liyWupd1+Q7eAeiMMvsNwkB6vX2SlySjz4TNydQbVt24LR2t39CSfW15uFbIzu0xQnaxw4QOfi86LSC4zF1Wo4KngvrvrW0WmzHw+prwJAoS8PJmdGLd+5NdjUp8uJc7ubG6m0l3rKz+FI44/XiUZWuqVva7xaTjloySkPNCeWd3163AC23hBYrDJ5UqZMDQrUEK9Yg4RcpORC/AH4ilayumuOI56wVZPJzTKejICFuUYKvZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTmoozpeEwRh14zYtREHexJpiEb5JlVS/eintpd2iNk=;
 b=VgbOUSktYgXdeWoHdKh3VUmSHA297glZIz+eHZZu96lHTKwdwPVw5uvVn69jy61DO/Ixqj44iCJkOv9S3GmnnXfWRBwUcvUyj//Ipj2hfX/CajCvxj+QBtygIN8jHuBnmQJK1753kNAW2beEjsnvrB5HgnowInxj7FverR23SZxzWz1WQCwTXYBBVSFtXhTwCMdUAaoByHVBAYCh1tksi2A53an8fm4hhO7Nllu993aS4gs+g4JiC2E/0E/sCTKN1J4n+cjVwsVBFbh1FlDFmLIub906i6yy0tM2KS1pR4LWfzlf1Xyl59lC5KDKOYZxUpmVHzXI4YlAson9hyenYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTmoozpeEwRh14zYtREHexJpiEb5JlVS/eintpd2iNk=;
 b=H6lPTR7ku3mkxLc3ExWtmffnynlz5w50pdhYKVWmAMY91aCGqjY2kgaDfMn9LbwAJDMNNy8KUY+g9WRpbMEGEO4SH7/lvd7hZcwxaqpzOYJMFmUaYdKQU5PGD3m6rWrFyV/ZmzVQWrjVhKAjEHBRTKKycPFfPtUTp3GU+abI8jE=
Received: from MN2PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:c0::36)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 10:52:17 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:c0:cafe::ca) by MN2PR05CA0023.outlook.office365.com
 (2603:10b6:208:c0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.9 via Frontend
 Transport; Wed, 4 Mar 2020 10:52:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 10:52:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 04:52:16 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 04:52:14 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Tao
 Zhou" <Tao.Zhou1@amd.com>, John Clements <John.Clements@amd.com>, Dennis Li
 <Dennis.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/6] drm/amdgpu: add wafl2 ip headers
Date: Wed, 4 Mar 2020 18:52:00 +0800
Message-ID: <20200304105203.6660-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304105203.6660-1-Hawking.Zhang@amd.com>
References: <20200304105203.6660-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(428003)(189003)(199004)(8936002)(336012)(36756003)(1076003)(8676002)(70586007)(26005)(70206006)(478600001)(2906002)(81156014)(186003)(81166006)(356004)(2616005)(5660300002)(6636002)(86362001)(426003)(6666004)(110136005)(7696005)(4326008)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3693; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392907d1-207b-4fec-d5a3-08d7c02a1add
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:
X-Microsoft-Antispam-PRVS: <MN2PR12MB369395F21DA0F76A8066C3B8FCE50@MN2PR12MB3693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI0stHeTzGUyCCr2mxtU6DuX6C0ar5kH9tDfs1Pvo0OchmcF4KWNT1UzfwZPo/87uQmw2xvCSQcbhYgGmAGmNYJMI/hRP4Y2BYOBbgMvgFUOEpaMcspLiMBN88VW9qWY20HY6dz3Kpy6upsb9nDAhwB5o0aVFzW30+2o7ssu45eh2efdoCj7bC1CdOPw1nqTeSxhpG7AzkXwO7nwDZeAphAf1do/60kQZfOl3wIPK9uLcjdkqtcgsOI23zc7awMTz3ednfRIJlyoGXhh6C3q0euL2gQSBkMCXntejiN/lxO94kfh7dqVwIqNXyIorCp9BGG50yBHpkvowKGAJhbmGDnXAowC12Z+Qgd4HjJFMZZdKq/2F/a/wn1uMfuM1cwDbyFPw9WY//BJtEqT2h6lQSux5c7bse107pge5/KQOm2h768foMnlTNWvn6jRzTcq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 10:52:16.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392907d1-207b-4fec-d5a3-08d7c02a1add
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
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

add wafl2 smn address and shift mask definition header files

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Guchun Chen <guchun.chen@amd.com>
---
 .../asic_reg/wafl/wafl2_4_0_0_sh_mask.h       | 69 +++++++++++++++++++
 .../include/asic_reg/wafl/wafl2_4_0_0_smn.h   | 29 ++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_smn.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_sh_mask.h
new file mode 100644
index 000000000000..82b6cc25205e
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_sh_mask.h
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
+#ifndef _wafl2_4_0_0_SH_MASK_HEADER
+#define _wafl2_4_0_0_SH_MASK_HEADER
+
+//PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DataLossErr__SHIFT						0x0
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__TrainingErr__SHIFT						0x1
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__CRCErr__SHIFT							0x5
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__BERExceededErr__SHIFT						0x6
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__TxMetaDataErr__SHIFT						0x7
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReplayBufParityErr__SHIFT					0x8
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DataParityErr__SHIFT						0x9
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReplayFifoOverflowErr__SHIFT					0xa
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReplayFifoUnderflowErr__SHIFT					0xb
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ElasticFifoOverflowErr__SHIFT					0xc
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DeskewErr__SHIFT						0xd
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DataStartupLimitErr__SHIFT					0xf
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__FCInitTimeoutErr__SHIFT						0x10
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__RecoveryTimeoutErr__SHIFT					0x11
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReadySerialTimeoutErr__SHIFT					0x12
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReadySerialAttemptErr__SHIFT					0x13
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__RecoveryAttemptErr__SHIFT					0x14
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__RecoveryRelockAttemptErr__SHIFT					0x15
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ClearBERAccum__SHIFT						0x17
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__BERAccumulator__SHIFT						0x18
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DataLossErr_MASK						0x00000001L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__TrainingErr_MASK						0x00000002L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__CRCErr_MASK							0x00000020L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__BERExceededErr_MASK						0x00000040L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__TxMetaDataErr_MASK						0x00000080L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReplayBufParityErr_MASK						0x00000100L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DataParityErr_MASK						0x00000200L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReplayFifoOverflowErr_MASK					0x00000400L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReplayFifoUnderflowErr_MASK					0x00000800L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ElasticFifoOverflowErr_MASK					0x00001000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DeskewErr_MASK							0x00002000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__DataStartupLimitErr_MASK					0x00008000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__FCInitTimeoutErr_MASK						0x00010000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__RecoveryTimeoutErr_MASK						0x00020000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReadySerialTimeoutErr_MASK					0x00040000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ReadySerialAttemptErr_MASK					0x00080000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__RecoveryAttemptErr_MASK						0x00100000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__RecoveryRelockAttemptErr_MASK					0x00200000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__ClearBERAccum_MASK						0x00800000L
+#define	PCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS__BERAccumulator_MASK						0xFF000000L
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_smn.h b/drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_smn.h
new file mode 100644
index 000000000000..4a51a90c611a
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/wafl/wafl2_4_0_0_smn.h
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
+#ifndef _wafl2_4_0_0_SMN_HEADER
+#define _wafl2_4_0_0_SMN_HEADER
+
+#define	smnPCS_GOPX1_0_PCS_GOPX1_PCS_ERROR_STATUS						0x11cf0210
+
+#endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
