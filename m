Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E1CC3F2D9
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8E7208C3
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 13:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a8LT9VKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8E7208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C096E32D;
	Thu,  5 Mar 2020 13:33:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BBA6E313
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 13:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1IlTRka0K47MF/JvnjP0kKhGrDSwfosxNVEqed/OFzNn+Aqd2e/C1sy5R6ErsUQojExOcU1UaIJavHq7+6f92GQKQhXH2iDvWjWm436LeyLCextGOzEG/7lCEn6/fEVCGhq4FOeQDXojPcwI0vHnoXHZyEhxKcrP9+OHD3+a44ToxzuUouWQQchOSV3A/MHU7epgFz5imABDxwAdSkvMtFaAVX55zJ/A5pT2Yt3Yedaqvn/m1eVHpUWPico0oplLL3ajo/52Kf6ph5y3YzkloqW+HjCBzCQjGrUvaqNzgMj1N2WGsWOIfQh8/BmqOnkzOeEVwN+EvUehvY3odXUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjrLU2WRnWxIQq3lKjSxBrw3xkMjDLqkPTBJVHT9Iak=;
 b=QJdiul9IAv19VJ+TAdz43BKv78LNPU79lf/ab1MWEfaRCPKNkitKA+BDXg7WjZPOzjpopPtca13RcXg2UGZwN+8/emNlYg2dCxHfpFnwyNpmq2RmDEXn7+X2E5/ZWqhZg+dfD8XsuObtNLkstyQhSqrg4hfILlC/MARimGXaligwng16KXYJKo2AHCA0HOJZz33/WAqbhWMSr6knL/XQRKswQgnensMRJ55+9u7L+PVMVq3f07dkiCVzDAVmlFbaE/VC4ovBl2LgyqVoocfGT/pyFZAJAtFxV1G7fj3cSV4wy+mITpHXBjhxzSQq94U3Yi/Z91MvS/bzoz282iLORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjrLU2WRnWxIQq3lKjSxBrw3xkMjDLqkPTBJVHT9Iak=;
 b=a8LT9VKQZuQptx7FE1kH7kn8J2grHAehauvlrEGwzssf8ccYNfgWuZ5tikdhKYNpV962oIIe/jAt/09CGfdQYB+Gg2KeAnQHL+sSRLwSrliiyAyVAUVmKbcECsGYk/VWNQLmEnrUMp5WwvDkcWkWr9WRA+xtMWm0sHgG9gpA8ec=
Received: from MWHPR14CA0071.namprd14.prod.outlook.com (2603:10b6:300:81::33)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Thu, 5 Mar
 2020 13:33:21 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::96) by MWHPR14CA0071.outlook.office365.com
 (2603:10b6:300:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 5 Mar 2020 13:33:21 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Thu, 5 Mar 2020 13:33:20 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 5 Mar 2020
 07:33:19 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 5 Mar 2020 07:33:18 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [enable VCN2.0 for NV12 SRIOV 1/6] drm/amdgpu: introduce mmsch v2.0
 header
Date: Thu, 5 Mar 2020 21:33:02 +0800
Message-ID: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(199004)(189003)(186003)(5660300002)(6916009)(2616005)(2906002)(4326008)(356004)(6666004)(30864003)(7696005)(86362001)(81156014)(81166006)(8676002)(478600001)(70206006)(70586007)(316002)(26005)(336012)(426003)(8936002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4287; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e6fe445-f192-46aa-8edc-08d7c109c585
X-MS-TrafficTypeDiagnostic: MN2PR12MB4287:
X-Microsoft-Antispam-PRVS: <MN2PR12MB428741AD0E480AE1B8FADEBD84E20@MN2PR12MB4287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03333C607F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAG+mgEF3TMkfyGL0FjefN6CMM22yI5jfo/Gz4uBn4luNqNV6fpEXDB2CLrwoxg00TxH4tkjJM0GAi3fLrfqwlKxpxOLV6nXfANIANcLxRyKD9rhXEHDC+eKUh5PgWKdmNWCxi5CiM5318IEnyQ9/22wAvoBPto9ZSVg9CwmgI21+MtbzF8OK79cvsmg5Q/0Prg0ik83DtBQ/JgYF208ctkSwJkTu0aP+rC/faMSQPFcXz1GCtP0ZQxVm591usexU+nQig/OwMgGhezZ9lNGroimw0LcxiolZ2OGhpKjVvqpyvKC4SRV3s/1FoIJgyQUK8J1B1KMU2BfvAklQSnXa2KllhdZDR2/pGjtHlpQ66l6fYjuVzEFGCmtJesKzRRJkcEUovY+ZIOGJycuCNMNKNUqAwdqFpHFVuct8fYZldUfxlZoLtvKmavUYi8ADq7w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 13:33:20.7336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6fe445-f192-46aa-8edc-08d7c109c585
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h | 338 ++++++++++++++++++++++++++++++++
 1 file changed, 338 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
new file mode 100644
index 0000000..1b5086c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
@@ -0,0 +1,338 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#ifndef __MMSCH_V2_0_H__
+#define __MMSCH_V2_0_H__
+
+// addressBlock: uvd0_mmsch_dec
+// base address: 0x1e000
+#define mmMMSCH_UCODE_ADDR                                                                             0x0000
+#define mmMMSCH_UCODE_ADDR_BASE_IDX                                                                    0
+#define mmMMSCH_UCODE_DATA                                                                             0x0001
+#define mmMMSCH_UCODE_DATA_BASE_IDX                                                                    0
+#define mmMMSCH_SRAM_ADDR                                                                              0x0002
+#define mmMMSCH_SRAM_ADDR_BASE_IDX                                                                     0
+#define mmMMSCH_SRAM_DATA                                                                              0x0003
+#define mmMMSCH_SRAM_DATA_BASE_IDX                                                                     0
+#define mmMMSCH_VF_SRAM_OFFSET                                                                         0x0004
+#define mmMMSCH_VF_SRAM_OFFSET_BASE_IDX                                                                0
+#define mmMMSCH_DB_SRAM_OFFSET                                                                         0x0005
+#define mmMMSCH_DB_SRAM_OFFSET_BASE_IDX                                                                0
+#define mmMMSCH_CTX_SRAM_OFFSET                                                                        0x0006
+#define mmMMSCH_CTX_SRAM_OFFSET_BASE_IDX                                                               0
+#define mmMMSCH_CTL                                                                                    0x0007
+#define mmMMSCH_CTL_BASE_IDX                                                                           0
+#define mmMMSCH_INTR                                                                                   0x0008
+#define mmMMSCH_INTR_BASE_IDX                                                                          0
+#define mmMMSCH_INTR_ACK                                                                               0x0009
+#define mmMMSCH_INTR_ACK_BASE_IDX                                                                      0
+#define mmMMSCH_INTR_STATUS                                                                            0x000a
+#define mmMMSCH_INTR_STATUS_BASE_IDX                                                                   0
+#define mmMMSCH_VF_VMID                                                                                0x000b
+#define mmMMSCH_VF_VMID_BASE_IDX                                                                       0
+#define mmMMSCH_VF_CTX_ADDR_LO                                                                         0x000c
+#define mmMMSCH_VF_CTX_ADDR_LO_BASE_IDX                                                                0
+#define mmMMSCH_VF_CTX_ADDR_HI                                                                         0x000d
+#define mmMMSCH_VF_CTX_ADDR_HI_BASE_IDX                                                                0
+#define mmMMSCH_VF_CTX_SIZE                                                                            0x000e
+#define mmMMSCH_VF_CTX_SIZE_BASE_IDX                                                                   0
+#define mmMMSCH_VF_GPCOM_ADDR_LO                                                                       0x000f
+#define mmMMSCH_VF_GPCOM_ADDR_LO_BASE_IDX                                                              0
+#define mmMMSCH_VF_GPCOM_ADDR_HI                                                                       0x0010
+#define mmMMSCH_VF_GPCOM_ADDR_HI_BASE_IDX                                                              0
+#define mmMMSCH_VF_GPCOM_SIZE                                                                          0x0011
+#define mmMMSCH_VF_GPCOM_SIZE_BASE_IDX                                                                 0
+#define mmMMSCH_VF_MAILBOX_HOST                                                                        0x0012
+#define mmMMSCH_VF_MAILBOX_HOST_BASE_IDX                                                               0
+#define mmMMSCH_VF_MAILBOX_RESP                                                                        0x0013
+#define mmMMSCH_VF_MAILBOX_RESP_BASE_IDX                                                               0
+#define mmMMSCH_VF_MAILBOX_0                                                                           0x0014
+#define mmMMSCH_VF_MAILBOX_0_BASE_IDX                                                                  0
+#define mmMMSCH_VF_MAILBOX_0_RESP                                                                      0x0015
+#define mmMMSCH_VF_MAILBOX_0_RESP_BASE_IDX                                                             0
+#define mmMMSCH_VF_MAILBOX_1                                                                           0x0016
+#define mmMMSCH_VF_MAILBOX_1_BASE_IDX                                                                  0
+#define mmMMSCH_VF_MAILBOX_1_RESP                                                                      0x0017
+#define mmMMSCH_VF_MAILBOX_1_RESP_BASE_IDX                                                             0
+#define mmMMSCH_CNTL                                                                                   0x001c
+#define mmMMSCH_CNTL_BASE_IDX                                                                          0
+#define mmMMSCH_NONCACHE_OFFSET0                                                                       0x001d
+#define mmMMSCH_NONCACHE_OFFSET0_BASE_IDX                                                              0
+#define mmMMSCH_NONCACHE_SIZE0                                                                         0x001e
+#define mmMMSCH_NONCACHE_SIZE0_BASE_IDX                                                                0
+#define mmMMSCH_NONCACHE_OFFSET1                                                                       0x001f
+#define mmMMSCH_NONCACHE_OFFSET1_BASE_IDX                                                              0
+#define mmMMSCH_NONCACHE_SIZE1                                                                         0x0020
+#define mmMMSCH_NONCACHE_SIZE1_BASE_IDX                                                                0
+#define mmMMSCH_PDEBUG_STATUS                                                                          0x0021
+#define mmMMSCH_PDEBUG_STATUS_BASE_IDX                                                                 0
+#define mmMMSCH_PDEBUG_DATA_32UPPERBITS                                                                0x0022
+#define mmMMSCH_PDEBUG_DATA_32UPPERBITS_BASE_IDX                                                       0
+#define mmMMSCH_PDEBUG_DATA_32LOWERBITS                                                                0x0023
+#define mmMMSCH_PDEBUG_DATA_32LOWERBITS_BASE_IDX                                                       0
+#define mmMMSCH_PDEBUG_EPC                                                                             0x0024
+#define mmMMSCH_PDEBUG_EPC_BASE_IDX                                                                    0
+#define mmMMSCH_PDEBUG_EXCCAUSE                                                                        0x0025
+#define mmMMSCH_PDEBUG_EXCCAUSE_BASE_IDX                                                               0
+#define mmMMSCH_PROC_STATE1                                                                            0x0026
+#define mmMMSCH_PROC_STATE1_BASE_IDX                                                                   0
+#define mmMMSCH_LAST_MC_ADDR                                                                           0x0027
+#define mmMMSCH_LAST_MC_ADDR_BASE_IDX                                                                  0
+#define mmMMSCH_LAST_MEM_ACCESS_HI                                                                     0x0028
+#define mmMMSCH_LAST_MEM_ACCESS_HI_BASE_IDX                                                            0
+#define mmMMSCH_LAST_MEM_ACCESS_LO                                                                     0x0029
+#define mmMMSCH_LAST_MEM_ACCESS_LO_BASE_IDX                                                            0
+#define mmMMSCH_IOV_ACTIVE_FCN_ID                                                                      0x002a
+#define mmMMSCH_IOV_ACTIVE_FCN_ID_BASE_IDX                                                             0
+#define mmMMSCH_SCRATCH_0                                                                              0x002b
+#define mmMMSCH_SCRATCH_0_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_1                                                                              0x002c
+#define mmMMSCH_SCRATCH_1_BASE_IDX                                                                     0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_0                                                                     0x002d
+#define mmMMSCH_GPUIOV_SCH_BLOCK_0_BASE_IDX                                                            0
+#define mmMMSCH_GPUIOV_CMD_CONTROL_0                                                                   0x002e
+#define mmMMSCH_GPUIOV_CMD_CONTROL_0_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_CMD_STATUS_0                                                                    0x002f
+#define mmMMSCH_GPUIOV_CMD_STATUS_0_BASE_IDX                                                           0
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_0                                                                0x0030
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_0_BASE_IDX                                                       0
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_0                                                                   0x0031
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_0_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_0                                                                 0x0032
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_0_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_DW6_0                                                                           0x0033
+#define mmMMSCH_GPUIOV_DW6_0_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW7_0                                                                           0x0034
+#define mmMMSCH_GPUIOV_DW7_0_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW8_0                                                                           0x0035
+#define mmMMSCH_GPUIOV_DW8_0_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_1                                                                     0x0036
+#define mmMMSCH_GPUIOV_SCH_BLOCK_1_BASE_IDX                                                            0
+#define mmMMSCH_GPUIOV_CMD_CONTROL_1                                                                   0x0037
+#define mmMMSCH_GPUIOV_CMD_CONTROL_1_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_CMD_STATUS_1                                                                    0x0038
+#define mmMMSCH_GPUIOV_CMD_STATUS_1_BASE_IDX                                                           0
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_1                                                                0x0039
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_1_BASE_IDX                                                       0
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_1                                                                   0x003a
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_1_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_1                                                                 0x003b
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_1_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_DW6_1                                                                           0x003c
+#define mmMMSCH_GPUIOV_DW6_1_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW7_1                                                                           0x003d
+#define mmMMSCH_GPUIOV_DW7_1_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW8_1                                                                           0x003e
+#define mmMMSCH_GPUIOV_DW8_1_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_CNTXT                                                                           0x003f
+#define mmMMSCH_GPUIOV_CNTXT_BASE_IDX                                                                  0
+#define mmMMSCH_SCRATCH_2                                                                              0x0040
+#define mmMMSCH_SCRATCH_2_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_3                                                                              0x0041
+#define mmMMSCH_SCRATCH_3_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_4                                                                              0x0042
+#define mmMMSCH_SCRATCH_4_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_5                                                                              0x0043
+#define mmMMSCH_SCRATCH_5_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_6                                                                              0x0044
+#define mmMMSCH_SCRATCH_6_BASE_IDX                                                                     0
+#define mmMMSCH_SCRATCH_7                                                                              0x0045
+#define mmMMSCH_SCRATCH_7_BASE_IDX                                                                     0
+#define mmMMSCH_VFID_FIFO_HEAD_0                                                                       0x0046
+#define mmMMSCH_VFID_FIFO_HEAD_0_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_TAIL_0                                                                       0x0047
+#define mmMMSCH_VFID_FIFO_TAIL_0_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_HEAD_1                                                                       0x0048
+#define mmMMSCH_VFID_FIFO_HEAD_1_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_TAIL_1                                                                       0x0049
+#define mmMMSCH_VFID_FIFO_TAIL_1_BASE_IDX                                                              0
+#define mmMMSCH_NACK_STATUS                                                                            0x004a
+#define mmMMSCH_NACK_STATUS_BASE_IDX                                                                   0
+#define mmMMSCH_VF_MAILBOX0_DATA                                                                       0x004b
+#define mmMMSCH_VF_MAILBOX0_DATA_BASE_IDX                                                              0
+#define mmMMSCH_VF_MAILBOX1_DATA                                                                       0x004c
+#define mmMMSCH_VF_MAILBOX1_DATA_BASE_IDX                                                              0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_0                                                                  0x004d
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_0_BASE_IDX                                                         0
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_0                                                                 0x004e
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_0_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0                                                              0x004f
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0_BASE_IDX                                                     0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_1                                                                  0x0050
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_1_BASE_IDX                                                         0
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_1                                                                 0x0051
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_1_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1                                                              0x0052
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1_BASE_IDX                                                     0
+#define mmMMSCH_GPUIOV_CNTXT_IP                                                                        0x0053
+#define mmMMSCH_GPUIOV_CNTXT_IP_BASE_IDX                                                               0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_2                                                                     0x0054
+#define mmMMSCH_GPUIOV_SCH_BLOCK_2_BASE_IDX                                                            0
+#define mmMMSCH_GPUIOV_CMD_CONTROL_2                                                                   0x0055
+#define mmMMSCH_GPUIOV_CMD_CONTROL_2_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_CMD_STATUS_2                                                                    0x0056
+#define mmMMSCH_GPUIOV_CMD_STATUS_2_BASE_IDX                                                           0
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_2                                                                0x0057
+#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_2_BASE_IDX                                                       0
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_2                                                                   0x0058
+#define mmMMSCH_GPUIOV_ACTIVE_FCNS_2_BASE_IDX                                                          0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_2                                                                 0x0059
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_2_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_DW6_2                                                                           0x005a
+#define mmMMSCH_GPUIOV_DW6_2_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW7_2                                                                           0x005b
+#define mmMMSCH_GPUIOV_DW7_2_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_DW8_2                                                                           0x005c
+#define mmMMSCH_GPUIOV_DW8_2_BASE_IDX                                                                  0
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_2                                                                  0x005d
+#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_2_BASE_IDX                                                         0
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_2                                                                 0x005e
+#define mmMMSCH_GPUIOV_CMD_STATUS_IP_2_BASE_IDX                                                        0
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2                                                              0x005f
+#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2_BASE_IDX                                                     0
+#define mmMMSCH_VFID_FIFO_HEAD_2                                                                       0x0060
+#define mmMMSCH_VFID_FIFO_HEAD_2_BASE_IDX                                                              0
+#define mmMMSCH_VFID_FIFO_TAIL_2                                                                       0x0061
+#define mmMMSCH_VFID_FIFO_TAIL_2_BASE_IDX                                                              0
+#define mmMMSCH_VM_BUSY_STATUS_0                                                                       0x0062
+#define mmMMSCH_VM_BUSY_STATUS_0_BASE_IDX                                                              0
+#define mmMMSCH_VM_BUSY_STATUS_1                                                                       0x0063
+#define mmMMSCH_VM_BUSY_STATUS_1_BASE_IDX                                                              0
+#define mmMMSCH_VM_BUSY_STATUS_2                                                                       0x0064
+#define mmMMSCH_VM_BUSY_STATUS_2_BASE_IDX                                                              0
+
+#define MMSCH_VERSION_MAJOR	2
+#define MMSCH_VERSION_MINOR	0
+#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
+
+enum mmsch_v2_0_command_type {
+	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
+	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
+	MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE = 3,
+	MMSCH_COMMAND__INDIRECT_REG_WRITE = 8,
+	MMSCH_COMMAND__END = 0xf
+};
+
+struct mmsch_v2_0_init_header {
+	uint32_t version;
+	uint32_t header_size;
+	uint32_t vcn_init_status;
+	uint32_t vcn_table_offset;
+	uint32_t vcn_table_size;
+};
+
+struct mmsch_v2_0_cmd_direct_reg_header {
+	uint32_t reg_offset   : 28;
+	uint32_t command_type : 4;
+};
+
+struct mmsch_v2_0_cmd_indirect_reg_header {
+	uint32_t reg_offset    : 20;
+	uint32_t reg_idx_space : 8;
+	uint32_t command_type  : 4;
+};
+
+struct mmsch_v2_0_cmd_direct_write {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+struct mmsch_v2_0_cmd_direct_read_modify_write {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+	uint32_t write_data;
+	uint32_t mask_value;
+};
+
+struct mmsch_v2_0_cmd_direct_polling {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+	uint32_t mask_value;
+	uint32_t wait_value;
+};
+
+struct mmsch_v2_0_cmd_end {
+	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
+};
+
+struct mmsch_v2_0_cmd_indirect_write {
+	struct mmsch_v2_0_cmd_indirect_reg_header cmd_header;
+	uint32_t reg_value;
+};
+
+static inline void mmsch_v2_0_insert_direct_wt(struct mmsch_v2_0_cmd_direct_write *direct_wt,
+					       uint32_t *init_table,
+					       uint32_t reg_offset,
+					       uint32_t value)
+{
+	direct_wt->cmd_header.reg_offset = reg_offset;
+	direct_wt->reg_value = value;
+	memcpy((void *)init_table, direct_wt, sizeof(struct mmsch_v2_0_cmd_direct_write));
+}
+
+static inline void mmsch_v2_0_insert_direct_rd_mod_wt(struct mmsch_v2_0_cmd_direct_read_modify_write *direct_rd_mod_wt,
+						      uint32_t *init_table,
+						      uint32_t reg_offset,
+						      uint32_t mask, uint32_t data)
+{
+	direct_rd_mod_wt->cmd_header.reg_offset = reg_offset;
+	direct_rd_mod_wt->mask_value = mask;
+	direct_rd_mod_wt->write_data = data;
+	memcpy((void *)init_table, direct_rd_mod_wt,
+	       sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write));
+}
+
+static inline void mmsch_v2_0_insert_direct_poll(struct mmsch_v2_0_cmd_direct_polling *direct_poll,
+						 uint32_t *init_table,
+						 uint32_t reg_offset,
+						 uint32_t mask, uint32_t wait)
+{
+	direct_poll->cmd_header.reg_offset = reg_offset;
+	direct_poll->mask_value = mask;
+	direct_poll->wait_value = wait;
+	memcpy((void *)init_table, direct_poll, sizeof(struct mmsch_v2_0_cmd_direct_polling));
+}
+
+#define MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(reg, mask, data) { \
+	mmsch_v2_0_insert_direct_rd_mod_wt(&direct_rd_mod_wt, \
+					   init_table, (reg), \
+					   (mask), (data)); \
+	init_table += sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write)/4; \
+	table_size += sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write)/4; \
+}
+
+#define MMSCH_V2_0_INSERT_DIRECT_WT(reg, value) { \
+	mmsch_v2_0_insert_direct_wt(&direct_wt, \
+				    init_table, (reg), \
+				    (value)); \
+	init_table += sizeof(struct mmsch_v2_0_cmd_direct_write)/4; \
+	table_size += sizeof(struct mmsch_v2_0_cmd_direct_write)/4; \
+}
+
+#define MMSCH_V2_0_INSERT_DIRECT_POLL(reg, mask, wait) { \
+	mmsch_v2_0_insert_direct_poll(&direct_poll, \
+				      init_table, (reg), \
+				      (mask), (wait)); \
+	init_table += sizeof(struct mmsch_v2_0_cmd_direct_polling)/4; \
+	table_size += sizeof(struct mmsch_v2_0_cmd_direct_polling)/4; \
+}
+
+#endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
