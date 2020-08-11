Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70827C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32310206C3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 03:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nVWlf3nC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32310206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB1A89B95;
	Tue, 11 Aug 2020 03:04:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF38989B95
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 03:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dhxpv2olvcJHsnnbrIW6tPLSnUjSQhBgDdpeNH/DdqkEm9bORlw2aGApUoZ692cX/DFcMrCYjjz/E2LcbtFqVCNUgiCqSyZYg1BVCRE4DsrFFrO4xi6JeJJc9RJHN8H36NhxcDKYXsuHWCMYBN66dYA7SkMKNxAA64lSE4LnnXR6NFIRwS4+3jXqACEEgysr1vUAHwEuxnujrCdYkXIOhlp/HZFYtoWop2gBKo0fKD20I8ZU+HN63Rig/ItT4IPfpWxBTXdql8qyLZkfn1qWm91JYfKt+C/NaHd5ZY2FjSjIZNJJorzx2trinuRC4693irKgU9njBXNaJbanvvD3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LCa29NsplvNmtiE1yPH7Wfqo0oU5E+q1rDQ1bmK2sQ=;
 b=I92/xmGx78romBH7X9fDoAtKc9tDMQGHrPmgE9uwVLZK4pJE4V37Wm2trmECg5D82gxbJXK0b0kcFscHAO0jql0Lq8i4AvrK87Zf64KTLDN8WLmzbFwciWzmaUD2PhAA11VbaOvFin4BvV9WVTzpjQlF7KxvdA0kUcrl6uHN8N+LX98pm55Bg4LFk3H4HarUPXbgsVtSuA4U0OrfJ6AzS6mz/m/+WCzNTdb16/4Ru3RR4LBRMXWAajTI5RtQRgVbFp8N5JRn8fdvRHiEHUiARkTrGLr/0xYc8u2jFZCE2Xt/qA90+reVJx/sHgK6QZK4YdaSy3NftvSm7oLk8Q99qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LCa29NsplvNmtiE1yPH7Wfqo0oU5E+q1rDQ1bmK2sQ=;
 b=nVWlf3nCmcpnI9IndIVgWZNreKuSvZTvfElka4Ytobb5jOZaLWRSDAroN7BxJVaHBv4DtA+s9C+imOdGibsDvt6Xbgxg5K3Ui9eEUqdaQBZkKxG7WINS4eDAigr1pyk2lZt7SGugSZRnTvGtwryi+D375e83HtDIAeFyxjJsF5w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 by CY4PR12MB1942.namprd12.prod.outlook.com (2603:10b6:903:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 03:04:04 +0000
Received: from CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f]) by CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f%3]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 03:04:04 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: add RAP TA header file
Date: Tue, 11 Aug 2020 11:03:43 +0800
Message-Id: <20200811030345.7334-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0057.apcprd03.prod.outlook.com
 (2603:1096:202:17::27) To CY4PR12MB1814.namprd12.prod.outlook.com
 (2603:10b6:903:125::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR03CA0057.apcprd03.prod.outlook.com (2603:1096:202:17::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 03:04:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29691b40-1d30-44c0-1744-08d83da33453
X-MS-TrafficTypeDiagnostic: CY4PR12MB1942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB19425B0FCBEB5F004539BA168C450@CY4PR12MB1942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aPN+knMZ0HsU37fR5ZRcHin/0mx03M6wzNEr5ZrsT/xvSMQsipnOoWYN+Y0ixFxO1BInY7aLsVQ6yCzI9N1ri8proatkz9a3tAwxk84HXQggeaqHPl4oizk9GaE5umY5LSLAw2j/aczehUPscVGWx1Dctt2s6324ujz+IDeDRhZ7ORc+Ns135b2XPWF+/+iyhQJsjug55EEjxvFD0vxdTbzMJxVYgMHu7u3HTloTSOHRcEQKJH9wQRyPvA0eO4uMd4iTNNmHQEdduEeV20ENx55zWQc4gNgl45pSP7hUokKXOWgQEXBvIosF7v4JzZ6FLJEYWGM0TZf26bBvNBv5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1814.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(7696005)(26005)(52116002)(186003)(54906003)(316002)(1076003)(16526019)(956004)(83380400001)(6486002)(6666004)(36756003)(2616005)(478600001)(5660300002)(2906002)(6916009)(8676002)(4326008)(86362001)(8936002)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4SzeR1DHgVOUtcrTnQUdLWzrcAZuLsSSyNNcQR/KwodhGXeXc5+80jDep/+CrNxNc2HDgvkhrtB2kbcsv0Vx27M0QyLTR8m4Nex/vmihD4DcbxpbaA/mmGQHWEjTS/M/t9e6FLBXirdskmdxZQVzT8G2aOVVnHrqLirRqum4n5EABF/075DnHGuTGSu/w/UNOgw0/FPm2NcJbgHOn3ikhnU9dFQ94mFIPppLE8zFtkH6UU0Vmby8EN923H/QtA409PuDlGZG1JJiIEoBuRLmjk0WC3hxTAoqDGbR0YMe3iEJWO8q0aynPi7cQrXto3qUBM/QKXhg34vyctyc2JcBzXYu610gNnX+MpugoBlEgqL0TPmqw8OrBBnFrnolh8oQBcor/Gg2t+bscYrezVCaSVSZdg2AfaRRY+eKRIstftOqVY0pPF1RC1IMMsbXVTU/eIYm/0Tapx6dZ/Aq0zs9XDaWyvMhMhnDhomK/xOrCRWiN4jJzl/yd44otvI+jq/mrHzcNTYvOWE4c0MJLna15UWlbSfipeIqLzhsyo28QxT3LPXLIsp4xK8oPQHHfOvfW11abgBe29vwLJhAxfIOsRxWJezzJpF+GICOWVWMzn4mp/c6Qjv224FFLW5QrjbSNxQYTtE4tBpWUQ9v7YE5/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29691b40-1d30-44c0-1744-08d83da33453
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 03:04:04.3317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuKlI+JdHBdUmd5dO+Eu/eOO7RLWLjQPffAdGTnhe11Sb83SFemuVKsxqySCxhu5F2/yWOULOKJ7h4rJRhrKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1942
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
Cc: John Clements <John.Clements@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The RAP TA contains tests used to verify if
RAP(Register Access Policy), or otherwise known
as Security Policy is applied correctly
by PSP BL&TOS.

The RAP test is a measure to ensure that we reduce
the avenue of complexity and mistakes when dealing
with RAP in post-si execution, where debugging failures
related to RAP is quite difficult and expensive.

v2: add introduction for RAP TA

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/ta_rap_if.h | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ta_rap_if.h

diff --git a/drivers/gpu/drm/amd/amdgpu/ta_rap_if.h b/drivers/gpu/drm/amd/amdgpu/ta_rap_if.h
new file mode 100644
index 000000000000..f14833fae07c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ta_rap_if.h
@@ -0,0 +1,84 @@
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
+#ifndef _TA_RAP_IF_H
+#define _TA_RAP_IF_H
+
+/* Responses have bit 31 set */
+#define RSP_ID_MASK (1U << 31)
+#define RSP_ID(cmdId) (((uint32_t)(cmdId)) | RSP_ID_MASK)
+
+enum ta_rap_status {
+	TA_RAP_STATUS__SUCCESS                              = 1,
+	TA_RAP_STATUS__ERROR_GENERIC_FAILURE                = 2,
+	TA_RAP_STATUS__ERROR_CMD_NOT_SUPPORTED              = 3,
+	TA_RAP_STATUS__ERROR_INVALID_VALIDATION_METHOD      = 4,
+	TA_RAP_STATUS__ERROR_NULL_POINTER                   = 5,
+	TA_RAP_STATUS__ERROR_NOT_INITIALIZED                = 6,
+	TA_RAP_STATUS__ERROR_VALIDATION_FAILED              = 7,
+	TA_RAP_STATUS__ERROR_ASIC_NOT_SUPPORTED             = 8,
+	TA_RAP_STATUS__ERROR_OPERATION_NOT_PERMISSABLE      = 9,
+	TA_RAP_STATUS__ERROR_ALREADY_INIT                   = 10,
+};
+
+enum ta_rap_cmd {
+	TA_CMD_RAP__INITIALIZE              = 1,
+	TA_CMD_RAP__VALIDATE_L0             = 2,
+};
+
+enum ta_rap_validation_method {
+	METHOD_A           = 1,
+};
+
+struct ta_rap_cmd_input_data {
+	uint8_t reserved[8];
+};
+
+struct ta_rap_cmd_output_data {
+	uint32_t    last_subsection;
+	uint32_t    num_total_validate;
+	uint32_t    num_valid;
+	uint32_t    last_validate_addr;
+	uint32_t    last_validate_val;
+	uint32_t    last_validate_val_exptd;
+};
+
+union ta_rap_cmd_input {
+	struct ta_rap_cmd_input_data input;
+};
+
+union ta_rap_cmd_output {
+	struct ta_rap_cmd_output_data output;
+};
+
+struct ta_rap_shared_memory {
+	uint32_t                    cmd_id;
+	uint32_t                    validation_method_id;
+	uint32_t                    resp_id;
+	enum ta_rap_status          rap_status;
+	union ta_rap_cmd_input      rap_in_message;
+	union ta_rap_cmd_output     rap_out_message;
+	uint8_t                     reserved[64];
+};
+
+#endif  // #define _TA_RAP_IF_H
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
