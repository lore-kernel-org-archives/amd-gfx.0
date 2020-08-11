Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF21AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9085D2054F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jjhMU7F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9085D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8236E0F4;
	Tue, 11 Aug 2020 06:30:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF3A6E0F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0h8eNmcVWcqO3nDrJ0Ouev0/f6eEWrSk5+/y301J0SU5GfcJ2+iLlG8UWW9Y8NikR8RAAqBzlg91pFmO/WasbP4u+aXrHvmdf7mmNg/Zs6WNKpvO6uqcsEkja6FxMKBf8TTYsiok90YbPxci9y8uudMcqZNBPPd3RYaaw6pq/3PY9AFOlAn8jKDeoghFT5GL7T9YcONcavW1Zw9oXzBrHh3CdwO/TdEJDR49TcJPfiIVCNLWfbqq/i3EXOrLHSvGXuWx8Az14CVLlKUgomaqu7LMDpDBVHAmXCjVNVPMXBP+GpX6tFq6zcRDa251nxwHCtGUCzpEHEv7/d4S+1F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LCa29NsplvNmtiE1yPH7Wfqo0oU5E+q1rDQ1bmK2sQ=;
 b=MiA5jyMdDB3YBMxu79KcNMwGarXs6uZxUZJ3sWAD2qLFHk8ceowVbckmUZpP4UqVPnFeHDEfHFnKMpppwY+d3lUi3HyrAFCtN4jpXSPB5ia57cZcf4LsBpxPdsKsNkLjrM8qcXCcaYD0dfrSnXsJ+hGQekU5LcRAE4LRt/INdyRS/qrZs8929VjKFQRDxyM8d/Z3awEk8/ZpKKXgfO0qPTC9tfdhpdYJl4fEiJC+RkqiFYghjwPN7SzyumhC3Z/v08lvp0qAtKhN7go7A3wGcR6CAUHuWl5+BgOCDbqQYf4WJ40a58GMX8GbJMRFeNOHYbMQXVDy1gE0fx9LrIVTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LCa29NsplvNmtiE1yPH7Wfqo0oU5E+q1rDQ1bmK2sQ=;
 b=jjhMU7F+JlDQhnIdDuScgA/dJAWIlGQfqnQIm7YKugw6G9O2qmVOA4HnE0SR5WQueS1EP63kg61cEArTdddpHoGSms6kaoRFf3kCpNAWzPDNE4zTQ0rggSsQEfO9XLTj/U0G1hT89jB9gt/H/dlvmfFzCbuMdEVaSPBHVqsZUws=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 by CY4PR12MB1319.namprd12.prod.outlook.com (2603:10b6:903:41::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.21; Tue, 11 Aug
 2020 06:30:22 +0000
Received: from CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f]) by CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f%3]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 06:30:22 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: add RAP TA header file
Date: Tue, 11 Aug 2020 14:30:05 +0800
Message-Id: <20200811063007.7785-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To CY4PR12MB1814.namprd12.prod.outlook.com
 (2603:10b6:903:125::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.5 via Frontend Transport; Tue, 11 Aug 2020 06:30:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ffe9999-d0a3-4ff3-ae8d-08d83dc00641
X-MS-TrafficTypeDiagnostic: CY4PR12MB1319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB13193A3220663CA09ADA47288C450@CY4PR12MB1319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pdSg37+uZ/e4tL28H/Z2eSk/tkru20lspyW27vOG05uCW2O6RSqS6HOzamYuV+0AKL+lkcs5jTPGGgPGeBZFY+MAW4ht7DibagMwRA5ahRhMDXx6EkDo3YoryKo5JVNso2l3mF6nIU2y6eKnUKsaksJYT5V0QtW5staPu1+FosCHB2CqahQYGT+hoWyEH8AvKkl/LhZVf1Ue+K+AkLv59myvTCkM4RFP/R/Iz24KbMiDtGEHMmzI1q20kq8QEPhyd0V8ezecyQm494o9t8nKtEp5kNSwUXtIoAXLiXTJrkuGhapjl5tCyogfeBGLdXiioN8VHMAn+xKdySXhKs4mxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1814.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(316002)(54906003)(52116002)(5660300002)(4326008)(6916009)(1076003)(6486002)(86362001)(8676002)(2906002)(8936002)(36756003)(26005)(7696005)(16526019)(83380400001)(186003)(66556008)(6666004)(956004)(66476007)(66946007)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /R4lUWNrY5+OpE7BjJDiuNtNtEV1Rj/3MC94j1N7wWIedbqC2+QuhS9H+BkN1O0x7EmnkQEAvevlcyn026P6+uMeTEfyZcc/VYq9zTxdXT1zez/E6U64k6GReqPhZw1o8mTOKm7jdJp3Wnmy7uweQsGvjBBsI5TV8GlmcGaIZ2RDZkdkErZqncYO1KmnxYiI38MaGGLtDDkffagSy+I8O/1u57Ndt7MeDViNuj0fMxCfBJKoz848QozD55l9+hDxUwugBZxX6bHn63/cG+Gu2iV2n00rwwEjE4twYJvxkKV89q4WeNx8WFQ+bm+v/vzTA7T22YbiHZbhzVb/TcSrVs1rbMn9eZNseXuhqmhbtYZwzvDMLSE2OyX9dG8glr/HzF8iGNEGaKJezD1D0dEow8MhGN2ia/cKIS/OKlBl76LItf4L3P8LQkPtYMriu8EmEgbs9nrZMx0uHc5bJTZS5C5ZO4eDhjvy9xXiOliz5qahD/GSWm+jjHgMKCcWzDV13s0hAdXCc3QXaYWaJGT33ydT1LOUDbtahZocVmow7EVvp9ey5sDdSD6VehVesNMr/lkA8sPfHYts/pYKHRw67TXD66Y09E3Yx9kyLGvFT1VovZOFrhsoDDl1tdThJMwwQpSL0eFrF1npRIOCcXjGtA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffe9999-d0a3-4ff3-ae8d-08d83dc00641
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 06:30:22.2887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf2VElvk/rMqjUO/jAICgRqQEGW+atDvateinVnnmWGGYDkaCgk20cYRSh5GOeJ8B+PNKH0cdMGLXseiVbUn/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1319
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
 Guchun Chen <Guchun.Chen@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
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
