Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C35C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B393D2376E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 08:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B393D2376E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4F46E81D;
	Fri,  8 Jan 2021 08:55:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A526E81D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 08:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJnp8R15FuazzyntW34X0SFQHj53RFTqzOJQDyGbRr8mGd3WhIGNjrnRDOo4SB4wp11ZRZWirZPWKfHHgbtjGZ/bQ4+2OsQ/07yeqLs42UmYVLMMeS7tMkIryQXmykxiuCWKegdbyYFvYdra0OcIeGbQHjAt2A53Qo5EKZaXhCfXdWZCKkaN/9Cs1+VSWUWAYYRAuD2Hp/LfR8KJ+7aCf2Y3Lvs+IsJoVA8o9bdBlmtt8TBkfg+IKFJhTQZ/6lABvns9cDkI5jIJjL7RHr/OLF8wzDkPFdOhoR2b6cE04P6mYWxrDhPqz+MjNg6S9MI0Yk6z4YCWdvzb5t6VGuMRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jsH1uWcKpJG+nBn1n3hMMc+E10c+cQjj5oqTY5A/bU=;
 b=LB+NBMbl7NgCrnCBb/bdUhFZ8uyvk5wKrAxFGn7QAbEOl0+PBOB4grSOW7ERpQBGNM+d98RrXEpm8rD5qaPEst/yZXw9j4tDXAe63nWgCHdfnMObmI/HAMts+hVYIs6aBalFstkbcnA307UPxADyQcijYdvoj6ynoPpy3h9vrsMAtYtNRq5B22D1zGyc7LS117px7/INgBjcs1eBFqs/sRa0JpOybF1ZfOzQcLJx63yoFDwMg3NLt/huHK62mG/Zq6rFm26wMXGj1kLAws/N5ATgTTXu64Kqhez1kAppNlY+a+dL6wS70bqVtSXTP++3ev5LQ3+Cxe6mf2cRVulSkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jsH1uWcKpJG+nBn1n3hMMc+E10c+cQjj5oqTY5A/bU=;
 b=Ks2WRt89u26lE/C/749xt1vyp+/JXhQgZjeOZdOTnEo7lt9w7XVyv3n8EuT+pGEvgx/2rCauM5/g+qMeEQ3P06bhOjPnbFgAo/NryrOjl9ksM+AEdZIYmmg12iZJfx6C6kuK8DARWjQQzYjltxgu/hidaqsq1gpR+ReP7XYJvA4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2458.namprd12.prod.outlook.com (2603:10b6:907:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 08:55:44 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 08:55:44 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amd/pm: implement processor fine grain feature for
 vangogh
Date: Fri,  8 Jan 2021 16:55:07 +0800
Message-Id: <20210108085507.1164588-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108085507.1164588-1-ray.huang@amd.com>
References: <20210108085507.1164588-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 08:55:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce7bfbdc-ad1e-40b7-d486-08d8b3b32f48
X-MS-TrafficTypeDiagnostic: MW2PR12MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2458008065920676FA3D0578ECAE0@MW2PR12MB2458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a56zFKBVIixrha3hTmhNyVF+q4x+/SAV8VTf3ZAJDB4jFez7GXoLNDuvr6bUAYhkLx378JhnzefEWr+RL+WoAtQi+G07/Lb2hZE3u+8BAIBM0bNPNnD9f3DwZz58UWHdThQas1gQni9ofIsdFxNwEZas0+tjBkE4rEkeFxc9NMJtg4JP+TOavk7r81YTnMT74M9+XdWsqbfb2l0k6/OiEOLmeRKw+oEhmifLGQLojuauy3DRj+iHpz/I53W+/qbHI2F/su12ni0mtHEFc3RCWdEiEiJ85rxntN2A2TTWXonQbTNAgNCS5Wcq1fiSuxtsANHz2yqCG4ZwOv/Pp/EfrEtORQlfIx3QNhwMKbyJuhAZExtkWUbc87QC0rs0S8EAc5hSlG9N9duKlahJ8DnNwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2616005)(956004)(83380400001)(36756003)(26005)(1076003)(7696005)(86362001)(4326008)(66946007)(6916009)(186003)(2906002)(8676002)(8936002)(52116002)(6666004)(6486002)(478600001)(316002)(66476007)(54906003)(66556008)(5660300002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wGLCu0PjoGybJeWHb9B3wkHDV+EXYma5vQ8zX8zMNRf/Om/26trnMLWwQF5V?=
 =?us-ascii?Q?B5IiiOD0sMCRu+kSIoP6M596dNhZQBaJhTaKOfX5W2xQ4wziWRBlJqfB3JJq?=
 =?us-ascii?Q?jMdyrPT4Al1BEdOCagbXcRa0q7GNMqG/wqUx1WqA8XSIEqZ1QqJxYACNSa9x?=
 =?us-ascii?Q?EFK9sHiJ3bNlDI1p5eLwZsYNHxvZp3wtf9741JoOAoe3c6v6Lop5gCsOy2Pr?=
 =?us-ascii?Q?Adh7Iu2Il2bk1jQCgdoqEIIqWcp1755DYMcfYwET9tJCcMmKzsSm3ZAQ6cmf?=
 =?us-ascii?Q?Z9Bu0hHkMJw8u3hLtlOkDoSdOaOhdMCNfW7uhVQlDHMHzF83DGAOtRI8ndHw?=
 =?us-ascii?Q?Wy+3neaL2NGaEfIfRvospCsa5nst7zUTqzZFWvoQ3s5Lxg20GUQVg/DimAkP?=
 =?us-ascii?Q?D+jLaEyGd+cCzPOTwovS0VLoHN0od3DHti/61Rhyc9O7QEFqQ2rjOm/rSkBN?=
 =?us-ascii?Q?dt8M4705jWbE29bEAIz1jUou6zk/z4iUDBE10dN+fMVfFe+E7p0lonkri3zH?=
 =?us-ascii?Q?ZFkyp/0+6zuL4gKk2LOlrIHmkOdzzYn4mMqNW8ePRg5G1771f3K/DbHFzjJq?=
 =?us-ascii?Q?axO/c/SZ7v0t+ukjA8WV5AUiY4HxRDkAyr6HiTMsu3NDkM69HofCzqliDpFn?=
 =?us-ascii?Q?rWPvAK0VPb8byjeAZ6wX4PJGDXkREV5TA3oV0e5Veq7Y14Gezr47rBpwohkq?=
 =?us-ascii?Q?rrxiI9LKSCFU+6J05g2OUSW2NZsCCA4RRy4ElrgX3kYG1cCtOZOCV8SwuOa0?=
 =?us-ascii?Q?HBVVYbZ9av4X1FHrwnzgWB0lVOrHrdgv/jPtzD1ry+pYUlF+alnrt8eN6nZG?=
 =?us-ascii?Q?ZHfZdNK/UCi+fku//rlyll5ndyt22or9eJHwK2nTNLSdV9noy6/Mr842gsuj?=
 =?us-ascii?Q?oevFsApq/QiLks1yG3RYDJHJafwFeeHyVV4cJEYLGDncbvvAfIhQ+0KXXq3v?=
 =?us-ascii?Q?M2Nar8vVTTjogx+MI7BSltxu+tDJ3e6tA0VGv58Bxa/2Qx9vavNyM7BN6kbN?=
 =?us-ascii?Q?YFYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 08:55:44.4886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7bfbdc-ad1e-40b7-d486-08d8b3b32f48
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPiVTp788CO1+RX0FreD3GKeSf2oeWsWzquSU6fSZZ5L2yKdwH7HXvB43GGXkdO9HdejIIfvbH2hSoa8hfHvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2458
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
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to implement the processor fine grain feature for vangogh.
It's similar with gfx clock, the only difference is below:

echo "p core_id level value" > pp_od_clk_voltage

1. "p" - set the cclk (processor) frequency
2. "core_id" - 0/1/2/3, represents which cpu core you want to select
2. "level" - 0 or 1, "0" represents the min value,  "1" represents the
   max value
3. "value" - the target value of cclk frequency, it should be limited in
   the safe range

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 ++
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 78 ++++++++++++++++++-
 5 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 57b24c4c205b..a41875ac5dfb 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -156,6 +156,7 @@ enum {
 enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_SCLK_VDDC_TABLE,
 	PP_OD_EDIT_MCLK_VDDC_TABLE,
+	PP_OD_EDIT_CCLK_VDDC_TABLE,
 	PP_OD_EDIT_VDDC_CURVE,
 	PP_OD_RESTORE_DEFAULT_TABLE,
 	PP_OD_COMMIT_DPM_TABLE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a5be03aa384b..298784f73705 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -800,6 +800,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 	if (*buf == 's')
 		type = PP_OD_EDIT_SCLK_VDDC_TABLE;
+	if (*buf == 'p')
+		type = PP_OD_EDIT_CCLK_VDDC_TABLE;
 	else if (*buf == 'm')
 		type = PP_OD_EDIT_MCLK_VDDC_TABLE;
 	else if(*buf == 'r')
@@ -916,6 +918,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDC_CURVE, buf+size);
 		size += smu_print_clk_levels(&adev->smu, SMU_OD_VDDGFX_OFFSET, buf+size);
 		size += smu_print_clk_levels(&adev->smu, SMU_OD_RANGE, buf+size);
+		size += smu_print_clk_levels(&adev->smu, SMU_OD_CCLK, buf+size);
 	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 97d788451624..5f781a27cfb7 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -465,6 +465,12 @@ struct smu_context
 	uint32_t gfx_default_soft_max_freq;
 	uint32_t gfx_actual_hard_min_freq;
 	uint32_t gfx_actual_soft_max_freq;
+
+	uint32_t cpu_default_hard_min_freq;
+	uint32_t cpu_default_soft_max_freq;
+	uint32_t cpu_actual_hard_min_freq;
+	uint32_t cpu_actual_soft_max_freq;
+	uint32_t cpu_core_id_select;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 8e428c728e0e..b76270e8767c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -237,6 +237,7 @@ enum smu_clk_type {
 	SMU_SCLK,
 	SMU_MCLK,
 	SMU_PCIE,
+	SMU_OD_CCLK,
 	SMU_OD_SCLK,
 	SMU_OD_MCLK,
 	SMU_OD_VDDC_CURVE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 63be82386964..4d02177cf9b0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -449,6 +449,15 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		}
 		break;
+	case SMU_OD_CCLK:
+		if (smu->od_enabled) {
+			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sprintf(buf + size, "0: %10uMhz\n",
+			(smu->cpu_actual_hard_min_freq > 0) ? smu->cpu_actual_hard_min_freq : smu->cpu_default_hard_min_freq);
+			size += sprintf(buf + size, "1: %10uMhz\n",
+			(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
+		}
+		break;
 	case SMU_OD_RANGE:
 		if (smu->od_enabled) {
 			size = sprintf(buf, "%s:\n", "OD_RANGE");
@@ -1245,7 +1254,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 }
 
 static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
-							long input[], uint32_t size)
+					long input[], uint32_t size)
 {
 	int ret = 0;
 
@@ -1255,6 +1264,34 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 	}
 
 	switch (type) {
+	case PP_OD_EDIT_CCLK_VDDC_TABLE:
+		if (size != 3) {
+			dev_err(smu->adev->dev, "Input parameter number not correct (should be 4 for processor)\n");
+			return -EINVAL;
+		}
+		if (input[0] >= boot_cpu_data.x86_max_cores) {
+			dev_err(smu->adev->dev, "core index is overflow, should be less than %d\n",
+				boot_cpu_data.x86_max_cores);
+		}
+		smu->cpu_core_id_select = input[0];
+		if (input[1] == 0) {
+			if (input[2] < smu->cpu_default_hard_min_freq) {
+				dev_warn(smu->adev->dev, "Fine grain setting minimum cclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+					input[2], smu->cpu_default_hard_min_freq);
+				return -EINVAL;
+			}
+			smu->cpu_actual_hard_min_freq = input[2];
+		} else if (input[1] == 1) {
+			if (input[2] > smu->cpu_default_soft_max_freq) {
+				dev_warn(smu->adev->dev, "Fine grain setting maximum cclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
+					input[2], smu->cpu_default_soft_max_freq);
+				return -EINVAL;
+			}
+			smu->cpu_actual_soft_max_freq = input[2];
+		} else {
+			return -EINVAL;
+		}
+		break;
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (size != 2) {
 			dev_err(smu->adev->dev, "Input parameter number not correct\n");
@@ -1286,6 +1323,8 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 		} else {
 			smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 			smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+			smu->cpu_actual_hard_min_freq = smu->cpu_default_hard_min_freq;
+			smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
 
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
 									smu->gfx_actual_hard_min_freq, NULL);
@@ -1300,6 +1339,20 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				dev_err(smu->adev->dev, "Restore the default soft max sclk failed!");
 				return ret;
 			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+							      smu->cpu_actual_hard_min_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set hard min cclk failed!");
+				return ret;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
+							      smu->cpu_actual_soft_max_freq, NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set soft max cclk failed!");
+				return ret;
+			}
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
@@ -1326,6 +1379,24 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				dev_err(smu->adev->dev, "Set soft max sclk failed!");
 				return ret;
 			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+							      ((smu->cpu_core_id_select << 20)
+							       | smu->cpu_actual_hard_min_freq),
+							      NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set hard min cclk failed!");
+				return ret;
+			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
+							      ((smu->cpu_core_id_select << 20)
+							       | smu->cpu_actual_soft_max_freq),
+							      NULL);
+			if (ret) {
+				dev_err(smu->adev->dev, "Set soft max cclk failed!");
+				return ret;
+			}
 		}
 		break;
 	default:
@@ -1351,6 +1422,11 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	smu->gfx_actual_hard_min_freq = 0;
 	smu->gfx_actual_soft_max_freq = 0;
 
+	smu->cpu_default_hard_min_freq = 1400;
+	smu->cpu_default_soft_max_freq = 3500;
+	smu->cpu_actual_hard_min_freq = 0;
+	smu->cpu_actual_soft_max_freq = 0;
+
 	return 0;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
