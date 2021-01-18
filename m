Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B21C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 12:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049BC221F8
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 12:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049BC221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FD96E207;
	Mon, 18 Jan 2021 12:33:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4426E207
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 12:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4/xfxN1L0kxCkgpxZQWm42ZICr1UP8GMY6S7FNbE1GIUGDR69WQ/u1vdT3U7JbD4n9VBkapF8EHvhzxNbD6FUIhmYAZ1rdftcBkWOrfXQoahJ7mKSTh3+yfDgI0OFxSJYUrt/B5eFo/4esxhEuvuvA5HJdSzULqRKAjNz9W9Vic0EGLR9Sm17WO08bECdQstKtlXUT/R2slfwkca6d02TK5aYRhkzHykla81DJxCK1YQOZoY89/XIDaikiQ4dUzMi0MoSikcSsc4cNPaJST5xNc+iL50dZrZefIebINvzTu9MsxLqwY+S6eBF0V4dE9xqiaebRQkV/+JexsGfh1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhGl3+cjEmhTR7nOjcqsni8L6csn2BbOGxstJ/02gfI=;
 b=m0fPS5yKUxsktbQgU4loirZkH2o0WIveJOcxTpS9tOQeKMRVXsD9FuM81ulIgUcjXixFxfcndHqdatbCnlbVx29iLQmcJz1ao1zArAHoolSEfLNWlAOHtORqXZwO45/A7UXGr8MBAP/VPrGiWo4IBocQC+At8dEFEJkw7h5Cnorle/3EAQJdoHgLYP3KL0+9QeabvMiCJppLpxga/d3ICVm5YGu5Duz2HOHOm10jzYtqh7pZ9+g1OerdCYqQoUfE+uJbjLDned0d9bf4pAyxUabgeEBly4v/iULDqtQhDFi3i+79x1RUr2Q7aNWDackLbNV3FHK3o3GOKOV0rXpecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhGl3+cjEmhTR7nOjcqsni8L6csn2BbOGxstJ/02gfI=;
 b=LoQRmZ75F9R4J5wr97XXU8KKLs8nrcpZTn90v9PdUWQJ+t7gGbpQjjz7K9UJQSySkvb3PbOKUd3ZOJylzWGoy/hlXpnWs+Fruyk6XdvHmAroAJi3aOIo6qFquOgWrpxA21M+PCH+JrzR3d1N4mrpyQoZ8mM6smZLVz1FPNQoaDQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1744.namprd12.prod.outlook.com (2603:10b6:300:111::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 12:33:10 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 12:33:10 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix build error without x86 kconfig (v2)
Date: Mon, 18 Jan 2021 20:32:48 +0800
Message-Id: <20210118123248.22570-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:202::18) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:202::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 12:33:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1303d224-f002-41fe-2bbc-08d8bbad3740
X-MS-TrafficTypeDiagnostic: MWHPR12MB1744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB174494B8EBDDF47CF66E3FD7ECA40@MWHPR12MB1744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rze3QqDkWcnaS+h0zdBpfflgBslCNMn6Jgw+J/oUKfDnQoBK046NjajsNql1K7r32xBvOjIjAHEkP0ajbUrW+x3WengSWFjs7Fu3Rg/VZuWXNI8KpRITYlmtWmvpJdsyJuMLbx21rlAEU67EDlBhXlCqA6gARiF3LGFgbQ9a0zXNuWyd4a9Z45C+Vs5m+ojUMRqv3yuyN0zh4BZWuQK8YOnzjHsigbXl9YjL+glxGM4rlZ51Y0CB415ndVYkYR6ARQEiOG43wekH64+7Rq9Gp2qyzLeb+jQv4xEskNG8+xnO8AtlJOdnyUa5UcqBc42gewiHFGT3CNk1S2jbuR+YKrWYyB/84N6i3/buBEpoReBea79d0Qxu0rV+c9mZfhUwgoWwsyXR556MvwqFMPI7+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(36756003)(186003)(66946007)(8936002)(2616005)(5660300002)(1076003)(2906002)(86362001)(6666004)(4326008)(66556008)(478600001)(316002)(16526019)(6486002)(66476007)(956004)(54906003)(8676002)(7696005)(52116002)(83380400001)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qfi63Dw1kCgBeyWcwdyif8zk+on3KYe7jWQIc1YlhQG/6DDq03rLXu7qPP/t?=
 =?us-ascii?Q?UonQlc5XVvMDfE0gcUTsEcEcXNyhyrqqK2N+xZH3nIRlnZ+1CRE87Mze8FjB?=
 =?us-ascii?Q?5jg0HfhozRCv35glRxGmnj2wOHGyKqYAtciZCUENdV1VmrOIXA+xjH/qhwWc?=
 =?us-ascii?Q?1oQP8FMtQXLa8vSUENEu8ac6HcvMEQMRnojbZikwpBSAluyPgt9nyi/eTROT?=
 =?us-ascii?Q?xFmacZmprrLASP9BhSO2SMHT623EydZwYNvN2GusQkb33zPSOAoRKjYt1CUJ?=
 =?us-ascii?Q?/JRTylUoFF5Tsoc49ypZrXlBQc2YhIMqjJSOnmMRa2VbOdbtWwuDNvF51Vbp?=
 =?us-ascii?Q?tn5PRtWmCshbuCKrd37MfmmY5hIy0ySF6jZuEu+mOxJ1cJhOR1helhxTZnwu?=
 =?us-ascii?Q?Abv0d5vEE/3b/xbQB2k5FnPxP8TuPUtwJyiGAVK/nqCMmxbj6XG0+wLSafIl?=
 =?us-ascii?Q?+9lfrzuIiFLCzhrKI4Msry7mmrkIRrtGNzKjW2P1q46/4jWTF66XGdOxtoY3?=
 =?us-ascii?Q?U/gA8RlaQMKC5HHEOZ1GJDZbyqf2JDGimAkB/dVxBlOdTkd6ASNzTIVO1Zrx?=
 =?us-ascii?Q?E2DMvSkdfqUTP/nJGWTD6sFwyroOdSa9GcUaaPMWtMBO84UJhy9t2PUAI/yV?=
 =?us-ascii?Q?lQ/OfZnSYYrlGpK0ps1hd+hhZl1v/8AO3addRYQnBi7mhVjxGB9FX2eVgFio?=
 =?us-ascii?Q?dKcFl3Ud5qvRgqNDdtIK6HmkgQahWl5ar+/aC5uYiYgmgFtvKP6h11MO55Xs?=
 =?us-ascii?Q?r4ZSQaWVi57qDccdr77nDibsJGiW53Kr2jEO5ArxMgfng8pGwyrPEK9Ld284?=
 =?us-ascii?Q?rOT1/vmwub1T38yQGNDcSF6Pmin+G0b48wXo/3VxONHZPXoHFCDF0Qp9ThF0?=
 =?us-ascii?Q?7T/RURKHWfOpJN1cGIQsfKtuNb64pE6Ij7dtMlRd7QiREnRrDfywRLuLWNiB?=
 =?us-ascii?Q?KHigMLH5G6UEzbK5svefjNqavsE+Uq16Cg8K4nVuavz79CljB0H4pdlj+WYX?=
 =?us-ascii?Q?1liR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1303d224-f002-41fe-2bbc-08d8bbad3740
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 12:33:10.6432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqPJrbw8YET/xuNawb7vEOcib8JJIwEK4i9tMP7XcpBK9FvF+yhro8KRje533BCS7gybvLyk/pE6tULbI0r1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1744
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to fix below build error while we are using the kconfig
without x86.

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function
'vangogh_get_smu_metrics_data':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:300:10:
error: 'boot_cpu_data' undeclared (first use in this function); did you
mean 'boot_cpuid'?
  300 |          boot_cpu_data.x86_max_cores * sizeof(uint16_t));
      |          ^~~~~~~~~~~~~
      |          boot_cpuid
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function
'vangogh_read_sensor':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1320:11:
error: 'boot_cpu_data' undeclared (first use in this function); did you
mean 'boot_cpuid'?
 1320 |   *size = boot_cpu_data.x86_max_cores * sizeof(uint16_t);
      |           ^~~~~~~~~~~~~
      |           boot_cpuid
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: In function
'vangogh_od_edit_dpm_table':
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:1460:19:
error: 'boot_cpu_data' undeclared (first use in this function); did you
mean 'boot_cpuid'?
 1460 |   if (input[0] >= boot_cpu_data.x86_max_cores) {
      |                   ^~~~~~~~~~~~~
      |                   boot_cpuid

v2: fix #ifdef and add comment for APU only

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c              |  4 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++++++++++-----
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 80d6298912aa..e9b569b76716 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3633,12 +3633,12 @@ static void amdgpu_debugfs_prints_cpu_info(struct seq_file *m,
 	int i;
 
 	if (is_support_cclk_dpm(adev)) {
-		p_val = kcalloc(boot_cpu_data.x86_max_cores, sizeof(uint16_t),
+		p_val = kcalloc(adev->smu.cpu_core_num, sizeof(uint16_t),
 				GFP_KERNEL);
 
 		if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_CPU_CLK,
 					    (void *)p_val, &size)) {
-			for (i = 0; i < boot_cpu_data.x86_max_cores; i++)
+			for (i = 0; i < adev->smu.cpu_core_num; i++)
 				seq_printf(m, "\t%u MHz (CPU%d)\n",
 					   *(p_val + i), i);
 		}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 25ee9f51813b..a087e00382e6 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -466,11 +466,13 @@ struct smu_context
 	uint32_t gfx_actual_hard_min_freq;
 	uint32_t gfx_actual_soft_max_freq;
 
+	/* APU only */
 	uint32_t cpu_default_soft_min_freq;
 	uint32_t cpu_default_soft_max_freq;
 	uint32_t cpu_actual_soft_min_freq;
 	uint32_t cpu_actual_soft_max_freq;
 	uint32_t cpu_core_id_select;
+	uint16_t cpu_core_num;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2f0cb0ea243b..dc41abe7b1d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -297,7 +297,7 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	case METRICS_AVERAGE_CPUCLK:
 		memcpy(value, &metrics->CoreFrequency[0],
-		       boot_cpu_data.x86_max_cores * sizeof(uint16_t));
+		       smu->cpu_core_num * sizeof(uint16_t));
 		break;
 	default:
 		*value = UINT_MAX;
@@ -335,6 +335,13 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_X86
+	/* AMD x86 APU only */
+	smu->cpu_core_num = boot_cpu_data.x86_max_cores;
+#else
+	smu->cpu_core_num = 4;
+#endif
+
 	return smu_v11_0_init_smc_tables(smu);
 }
 
@@ -1317,7 +1324,7 @@ static int vangogh_read_sensor(struct smu_context *smu,
 		ret = vangogh_get_smu_metrics_data(smu,
 						   METRICS_AVERAGE_CPUCLK,
 						   (uint32_t *)data);
-		*size = boot_cpu_data.x86_max_cores * sizeof(uint16_t);
+		*size = smu->cpu_core_num * sizeof(uint16_t);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -1457,9 +1464,9 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 			dev_err(smu->adev->dev, "Input parameter number not correct (should be 4 for processor)\n");
 			return -EINVAL;
 		}
-		if (input[0] >= boot_cpu_data.x86_max_cores) {
+		if (input[0] >= smu->cpu_core_num) {
 			dev_err(smu->adev->dev, "core index is overflow, should be less than %d\n",
-				boot_cpu_data.x86_max_cores);
+				smu->cpu_core_num);
 		}
 		smu->cpu_core_id_select = input[0];
 		if (input[1] == 0) {
@@ -1535,7 +1542,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				break;
 			}
 
-			for (i = 0; i < boot_cpu_data.x86_max_cores; i++) {
+			for (i = 0; i < smu->cpu_core_num; i++) {
 				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
 								      (i << 20) | smu->cpu_actual_soft_min_freq,
 								      NULL);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
