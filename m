Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E87C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5F12076B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P+unOY2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5F12076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A0389FF9;
	Mon,  1 Jun 2020 07:30:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65EE389FF9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctms4I97qLWtD5lJY8KUYnG5zPvqk/wCRDJCJx7AMPYanxP9rQmEt8TjHXq0IupzBo02YLvPuWBfGOV065CxCThy1+G6NFuYDQgxPWkkS2UFstoFPFt3lQYm43EPjUaGxQAQRUtznSu9ysr+/7HIl0Al0kE6kbpjRIo3A8C6HyYr0RC+NGBuqz1elvRqw3tcMl1sdZdmvC13YJYajVOQOjYVMBpaaL7vhUc3CObZv73sEEHHwzkJQTn1UGdhuxQNC0GGH2jmIVoPpuMTZsuEIFXoAfPqcWOl261+j1fnmXvXqwNWjwaBdgYJ9DFroyYK7WWb3BZovy7SLBGdrCmzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpHaXTIio2B+/G3/opsz66POqwCZG6B7Jz0YuBmEcd4=;
 b=Oft8F9aVwCDzy8uRSME+0XrTWIzecGusTayBLBCWYRlrWJhv0IrS3SFEuWDJki+rA9y2Q1nGaunPAwxMISIVSjiZ1hK8AiHcMDwG2F0jodw1OYgXVD4xq7O8/RwBmDWZpZkOrriMlpKNhwJk+J+rBXGfLKrDVg2Pp52jIF5B+bBz6eHb43nd5s3i9VQAYZEpiYyYjaZ8U/uYhNnbFkUD2dPxGiWJVNtIYUdV5iGJ2cEhBzbm07MWGkGxdffX2ZKKP/zsPzs1GCKW6V1rCPwmJjyt6GhgLtKdfqNst2NPNaNIAznU15cYll8dcH2YjemwGzvdm1ojxMS9ATLvgQjUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpHaXTIio2B+/G3/opsz66POqwCZG6B7Jz0YuBmEcd4=;
 b=P+unOY2pJojepQkM1mgbAdiLnkkJ/rx8YCJvBIihWPUwqGUfLBNGD9cjVNZkNCTkqeRmWjz5HITUlvIX26CxMUuIYh9SNjWcIKXEzRgGOQ2JJN2U+pLhmi7Y5S0/LzX3yFLqiPSjDPJZAylRMMg2r/qAdmMQ1jSG4y8cXfebX6A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:30:55 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:30:55 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/9] drm/amd/powerplay: clean up the APIs for bootup clocks
Date: Mon,  1 Jun 2020 15:29:58 +0800
Message-Id: <20200601073003.13044-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:30:53 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fea359f6-81ac-48dd-4ed7-08d805fdb857
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803DAD199B3BC4BC3D9E7E3E48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpTYMwe3px8H58Avz5iNm6Zyo34VsEdpBw+lxsUUMKfxlkf12nU0dWUWwUecuOlfv5o/FPCvZDUzwkPS6o9a1Fy1XcvlqAivqgX7Jrbc3KkbHfV5jSIPVqdeF8WZk4zG4V2/RDwsNMpCqX+huOVwFl1hJuYhFmItnVoiP3jQya6pOpxsSJoa3xCH+OuKU8wigjvueTSU9zbpJkxlwG0XgOxn6+P/capZ9MeMshi1mk7R891/6jxEqJU78y3fQIU0orjwMmbN8x7qscFhCWxyyRCE3bNHGxfqVhAlxTT7xtp7FybCDHMMn1dv3tla8ECuUuvNClkuhYs897PIGcqJqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(30864003)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0g1zzw7UyZP/lYmXyyv6Y4BUiIZveNmAuqESm2rTM8YoiaAz1wN16U6TrMHr4AOsyOB5mshzLcMamxlXxBh59xF3MkQIVL8FqhQO/urMVkDzfaK/UdQ93OpxCSieDyZ/7OxJMTSzWw6N595IrbO9LxDIaebqib+eAku0wGp9LeZPLCvdsqtKJ3uksjjq+o6pFmFKXf4JUOUDpfxtCdWIo6kHEh1DIi1YMSl2d0B8tn3sMJYvZDnRmSCmuJJsE75oNNYBqPbwK1PXyXFDGDcBVLO/9ekeYqrZ3LCwOSfijP7+c6IKe3yiVByshg29/x0DVEDraZaf3OI5QKNR/hC8iXfP5mBwRFsPKsqOte5v4xdKtJ7C68BIqbp3jVlPywaAzW2fppghUeZ8bF+2hSVI5F44yk4g8nezJaZwhuaRlQlSPIXy1TG0ShHD4RTbkCNOahzWCxjQkZFEifTAYn2qgut5aNYAS397UhQZoUcyzORUBWfTu51RHJoOs/savsx5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea359f6-81ac-48dd-4ed7-08d805fdb857
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:30:55.2678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNhpkBu1WNT21NesgVlMEFSvw5UwoS0uJgDd3qeVpCctgDSn5L7ZGoq2HxhIvJs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Combine and simplify the logics for retrieving bootup
clocks.

Change-Id: Ifca28c454f3769dece0cc705ba054ff34db0ab60
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |   4 -
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |   1 -
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   1 -
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |   2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |   1 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |   2 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 141 +++++++-----------
 7 files changed, 51 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 70c7b3fdee79..9bafa6b3e123 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1132,10 +1132,6 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		ret = smu_get_clk_info_from_vbios(smu);
-		if (ret)
-			return ret;
-
 		/*
 		 * check if the format_revision in vbios is up to pptable header
 		 * version, and the structure size is not 0.
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index e856ad36ab01..902c8cfa4a3b 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2423,7 +2423,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = smu_v11_0_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.get_clk_info_from_vbios = smu_v11_0_get_clk_info_from_vbios,
 	.check_pptable = smu_v11_0_check_pptable,
 	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 5bb1ac821aeb..223678e329a5 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -505,7 +505,6 @@ struct pptable_funcs {
 	int (*check_fw_status)(struct smu_context *smu);
 	int (*setup_pptable)(struct smu_context *smu);
 	int (*get_vbios_bootup_values)(struct smu_context *smu);
-	int (*get_clk_info_from_vbios)(struct smu_context *smu);
 	int (*check_pptable)(struct smu_context *smu);
 	int (*parse_pptable)(struct smu_context *smu);
 	int (*populate_smc_tables)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 71f829ab306e..5b785816aa64 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -161,8 +161,6 @@ int smu_v11_0_setup_pptable(struct smu_context *smu);
 
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu);
 
-int smu_v11_0_get_clk_info_from_vbios(struct smu_context *smu);
-
 int smu_v11_0_check_pptable(struct smu_context *smu);
 
 int smu_v11_0_parse_pptable(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 652728f18271..bea6a96b5afb 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2320,7 +2320,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.setup_pptable = smu_v11_0_setup_pptable,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
-	.get_clk_info_from_vbios = smu_v11_0_get_clk_info_from_vbios,
 	.check_pptable = smu_v11_0_check_pptable,
 	.parse_pptable = smu_v11_0_parse_pptable,
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 6c59eeef2590..a31df7f4e91a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -47,8 +47,6 @@
 
 #define smu_get_vbios_bootup_values(smu) \
 	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
-#define smu_get_clk_info_from_vbios(smu) \
-	((smu)->ppt_funcs->get_clk_info_from_vbios ? (smu)->ppt_funcs->get_clk_info_from_vbios((smu)) : 0)
 #define smu_check_pptable(smu) \
 	((smu)->ppt_funcs->check_pptable ? (smu)->ppt_funcs->check_pptable((smu)) : 0)
 #define smu_parse_pptable(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 3b22f66e3fbc..be6dca8c6014 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -558,6 +558,32 @@ int smu_v11_0_fini_power(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v11_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
+					    uint8_t clk_id,
+					    uint8_t syspll_id,
+					    uint32_t *clk_freq)
+{
+	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
+	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
+	int ret, index;
+
+	input.clk_id = clk_id;
+	input.syspll_id = syspll_id;
+	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
+	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
+					    getsmuclockinfo);
+
+	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
+					(uint32_t *)&input);
+	if (ret)
+		return -EINVAL;
+
+	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
+	*clk_freq = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+
+	return 0;
+}
+
 int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 {
 	int ret, index;
@@ -616,102 +642,37 @@ int smu_v11_0_get_vbios_bootup_values(struct smu_context *smu)
 	smu->smu_table.boot_values.format_revision = header->format_revision;
 	smu->smu_table.boot_values.content_revision = header->content_revision;
 
-	return 0;
-}
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_SOCCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.socclk);
 
-int smu_v11_0_get_clk_info_from_vbios(struct smu_context *smu)
-{
-	int ret, index;
-	struct amdgpu_device *adev = smu->adev;
-	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
-	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.dcefclk);
 
-	input.clk_id = SMU11_SYSPLL0_SOCCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_ECLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.eclk);
 
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.socclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_VCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.vclk);
 
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_DCEFCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.dcefclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_ECLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.eclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_VCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.vclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-
-	memset(&input, 0, sizeof(input));
-	input.clk_id = SMU11_SYSPLL0_DCLK_ID;
-	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-					    getsmuclockinfo);
-
-	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-					(uint32_t *)&input);
-	if (ret)
-		return -EINVAL;
-
-	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-	smu->smu_table.boot_values.dclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+	smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+					 (uint8_t)SMU11_SYSPLL0_DCLK_ID,
+					 (uint8_t)0,
+					 &smu->smu_table.boot_values.dclk);
 
 	if ((smu->smu_table.boot_values.format_revision == 3) &&
-	    (smu->smu_table.boot_values.content_revision >= 2)) {
-		memset(&input, 0, sizeof(input));
-		input.clk_id = SMU11_SYSPLL1_0_FCLK_ID;
-		input.syspll_id = SMU11_SYSPLL1_2_ID;
-		input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-		index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
-						    getsmuclockinfo);
-
-		ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
-						(uint32_t *)&input);
-		if (ret)
-			return -EINVAL;
-
-		output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
-		smu->smu_table.boot_values.fclk = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
-	}
+	    (smu->smu_table.boot_values.content_revision >= 2))
+		smu_v11_0_atom_get_smu_clockinfo(smu->adev,
+						 (uint8_t)SMU11_SYSPLL1_0_FCLK_ID,
+						 (uint8_t)SMU11_SYSPLL1_2_ID,
+						 &smu->smu_table.boot_values.fclk);
 
 	return 0;
 }
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
