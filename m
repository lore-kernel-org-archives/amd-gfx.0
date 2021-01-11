Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B74FC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5E4224D3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5E4224D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F5E89AD2;
	Mon, 11 Jan 2021 04:27:08 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8942489AD2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 04:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwueBfmPtePP8+BUzx4WSCTu/wYeY8oFjJP2A+JxxWDB2SCWhLiAevnSpcLUfYqv7NsJWyA708u5XC02GUQYaoa5Osy60mVOyt9Inwz0fP5GWOiulnncQYnWifexitXxH7wcAmqDvwSjvcllZ1vuXNHe0X5Aoi+MZdZTCfd43hJXoUI/pONodJxaNqyqmI2OXxGnpo/lZELO9FNQWChfWjdeO74TgFVe0XcT+orUJR2Isiz3F6WPD2TDn/6Kj0uk+Pn1tsGxONjkuOcmEdU3LWqVNWCnpkNOBdwPBhFsLUrXcbTM1UxWDDFIiTM0E/feMcxAoTsIXDVrZYXdI5e9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyNjt0ANFc1+PXD+LPpPO+1hhXQk2dAF6Pa2Gs93TlU=;
 b=dTa4gbweR5LmMYmQ1dl7KOsrw/mnSNTj7tw4hJrLkzeW7s+c+N2kGukZ9e+GaqYRl9l/sJgvUhEbq0bFcsi7F/n+d1gR7jT6ZvTid+XFsnOOK55A+5VhIA16C8tDdqhwg7ZfkMjfDboC6+Nu4Robt4SfIoV1YXQUl+A/oaimVE+oInct7mO/biRhVIC815T5/2T0b2DzNGJzafZxJ9H0GfDBKm478twaXYEXXBq6AOWOTwuVF+AyBN4d47QDGapumy9oLlGAzLcj5gEF5PwecgP0q2gcb9A0qP9NQEaHFQ6yHXno+pe/1q/EyAGjC2g2jAsQYuwg46T8HN3EiZ2JCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyNjt0ANFc1+PXD+LPpPO+1hhXQk2dAF6Pa2Gs93TlU=;
 b=cNALODuvwFzz1h2CiGVHkDiObWkHLRKsozlxM/75LCBr2X4LETb3jzj3A9S+QJ3goSE8rvjgqH/3i4GQyi8pqV928YlQstPw7uoo4obOZbZGAWNGDbH9cegBsZZPH3cTveeTfN8WDeWfk8QGWBO3kUxoLzAf0UP19MdbOVPJhRQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1792.namprd12.prod.outlook.com (2603:10b6:300:114::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 04:27:05 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 04:27:05 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 7/7] drm/amd/pm: implement processor fine grain feature for
 vangogh (v2)
Date: Mon, 11 Jan 2021 12:26:10 +0800
Message-Id: <20210111042610.2234748-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111042610.2234748-1-ray.huang@amd.com>
References: <20210111042610.2234748-1-ray.huang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 04:27:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a82c8a1d-67f9-4850-da41-08d8b5e9268d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1792FCFFDA2FD1F3E56468C7ECAB0@MWHPR12MB1792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3OJOAeE0CX0YhtjL0qUZ+D6bYeloOFoVnsG7gO3MgpwME0YTBQjClkjeJIo1eek95vu71RH8MZEXyGnPVbRvPIlZxwbwDekXat0pAtptwuE9dklrnlLNbLnhqA0EOk7wDVAjvUO0Z/+W3BFiHVjCg5PVmLtYNI0+nePE0FgoXjGhWWYsBONVmYmgDYbBP4xsNNNaz//uTXUKRQjnWgAWQN/WEKRgojPnKdI3hQzhTeNTqu8TommmIoWF5zfI0hA9u55KtlCAVtbuvcCRcArKWFZAwyFgVZdmvgOl2kluhgQh79FmkLUBhRtFEaRMMGYgIpArZSTA73rXzhr9Ega7DuuJoIkJV5Eqp7HUlRsx9dSguQyhW6c5hf+yRHecbI5XR2eoxUN0Sheq0b+/dSlKAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(316002)(1076003)(66476007)(54906003)(66946007)(6486002)(5660300002)(66556008)(26005)(83380400001)(16526019)(956004)(8936002)(6666004)(86362001)(4326008)(186003)(478600001)(2906002)(7696005)(36756003)(52116002)(6916009)(2616005)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KwC0JgCdlRMHyx3pf58uT2olniaIFaGsKgV7D0DcxO1R7IinnfxTzKC/TSYv?=
 =?us-ascii?Q?FzG2bHzjoW/AWEuLOnTqlaqGUahf8f0iPiyxOQ66K51Ij8NOtxFim5j6ZOyL?=
 =?us-ascii?Q?1CT/nqm5avHGCgcQRhCquLKV5kYdjJM7ufF3Cqpdt41K3VrOEoCraAQsFdFT?=
 =?us-ascii?Q?ybHTfqY1UPDjIWECk5mIhvjIu4uJ2gEHvIrgbhQQFQJdJEa+B7wAxrbVsPfV?=
 =?us-ascii?Q?uNorjZCibZkP0qvo2LKiBgvoTLN0FLYHXtDXwyUfF7KalAp95WhyE15UvnY9?=
 =?us-ascii?Q?d0CPGEGJl9WNpFkFTP8+guNrnUsU2YuBszFRXZ14546DKr7NE8SB8sc5F4mt?=
 =?us-ascii?Q?rA4piDCc0V+x7wPr2ht+BdcFh9ZEcvnDi/BhHFjLOuMrK7wsEFkPfnoBjRH2?=
 =?us-ascii?Q?4WdnJ89GWqs2qSny8QCJM8w9d5GFy7FLmauSKAPTBnaxu5UJSvQlNGRrw4LV?=
 =?us-ascii?Q?WW4EeTaVlAo+b0XraEl3RWEIRtxHbkC/Ixbh0WyWXTrDZsvbGQGQOms7LnLl?=
 =?us-ascii?Q?0A1sxJp43ZkYgnuXbQ7EY68MlCWii2wfleN39BZAAubRyN0GHas8Lq3RkV/S?=
 =?us-ascii?Q?qnA8xzkB13U+XFcm1HzvVSnTmryNbwCyZvtb+4sx86MEVwf5qMCXWzDCqsZ0?=
 =?us-ascii?Q?9d+oWHYvJBoV4I2RAYXcQf9FOTcgZFRCtywgUDeqjuoULopvT/l+AaE5+DqE?=
 =?us-ascii?Q?BZzshBYUq4NEGFSZge/pLbtEI5sa6s4Cud0iWiOd9Eo54sU0R8qAtZ156gxP?=
 =?us-ascii?Q?etjFYX3ot/wO+x1fFFHyvp0J8QQ27NqyQVLvYwJP/Ty2+YUkZhCSNEvF0fsC?=
 =?us-ascii?Q?cUo9wXCBZeekGLmwcLNVRJjqS2+xLfL3is2sRhoh6m6XXefnFEDYXy8Ig4T+?=
 =?us-ascii?Q?DUoSYL/yMIpbwla3lWPG+MeJV3RXpVHwJTraT+V/tBCXpxSlucmQST8VfbeM?=
 =?us-ascii?Q?ahAVV37eaSmdy8k5i4fIUSylFBG4zurBaFOBgNaAD5X3FAP+3lzpe4Dj86G6?=
 =?us-ascii?Q?6ND4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 04:27:05.0004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: a82c8a1d-67f9-4850-da41-08d8b5e9268d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFnvL5v5GZ0uFyW0v6Zah0XJBe6VklLyE80H+BkajDfErOXoPfmINnl6uaSG3Jf3pKkAL4F57bFSANJXUX3v5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
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
Cc: Xiaojian Du <xiaojian.du@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaomeng Hou <Xiaomeng.Hou@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
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

v2: fix some missing changes as Evan's suggestion.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  6 ++
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 80 ++++++++++++++++++-
 5 files changed, 90 insertions(+), 1 deletion(-)

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
index a5be03aa384b..75cefcb25a44 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -800,6 +800,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 	if (*buf == 's')
 		type = PP_OD_EDIT_SCLK_VDDC_TABLE;
+	else if (*buf == 'p')
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
index 97d788451624..25ee9f51813b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -465,6 +465,12 @@ struct smu_context
 	uint32_t gfx_default_soft_max_freq;
 	uint32_t gfx_actual_hard_min_freq;
 	uint32_t gfx_actual_soft_max_freq;
+
+	uint32_t cpu_default_soft_min_freq;
+	uint32_t cpu_default_soft_max_freq;
+	uint32_t cpu_actual_soft_min_freq;
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
index 63be82386964..b2b2955c1024 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -449,11 +449,22 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 			(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
 		}
 		break;
+	case SMU_OD_CCLK:
+		if (smu->od_enabled) {
+			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
+			size += sprintf(buf + size, "0: %10uMhz\n",
+			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
+			size += sprintf(buf + size, "1: %10uMhz\n",
+			(smu->cpu_actual_soft_max_freq > 0) ? smu->cpu_actual_soft_max_freq : smu->cpu_default_soft_max_freq);
+		}
+		break;
 	case SMU_OD_RANGE:
 		if (smu->od_enabled) {
 			size = sprintf(buf, "%s:\n", "OD_RANGE");
 			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+			size += sprintf(buf + size, "CCLK: %7uMhz %10uMhz\n",
+				smu->cpu_default_soft_min_freq, smu->cpu_default_soft_max_freq);
 		}
 		break;
 	case SMU_SOCCLK:
@@ -1245,7 +1256,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 }
 
 static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type,
-							long input[], uint32_t size)
+					long input[], uint32_t size)
 {
 	int ret = 0;
 
@@ -1255,6 +1266,34 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
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
+			if (input[2] < smu->cpu_default_soft_min_freq) {
+				dev_warn(smu->adev->dev, "Fine grain setting minimum cclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
+					input[2], smu->cpu_default_soft_min_freq);
+				return -EINVAL;
+			}
+			smu->cpu_actual_soft_min_freq = input[2];
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
@@ -1286,6 +1325,8 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 		} else {
 			smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 			smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+			smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+			smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
 
 			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
 									smu->gfx_actual_hard_min_freq, NULL);
@@ -1300,6 +1341,20 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				dev_err(smu->adev->dev, "Restore the default soft max sclk failed!");
 				return ret;
 			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+							      smu->cpu_actual_soft_min_freq, NULL);
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
@@ -1326,6 +1381,24 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 				dev_err(smu->adev->dev, "Set soft max sclk failed!");
 				return ret;
 			}
+
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
+							      ((smu->cpu_core_id_select << 20)
+							       | smu->cpu_actual_soft_min_freq),
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
@@ -1351,6 +1424,11 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	smu->gfx_actual_hard_min_freq = 0;
 	smu->gfx_actual_soft_max_freq = 0;
 
+	smu->cpu_default_soft_min_freq = 1400;
+	smu->cpu_default_soft_max_freq = 3500;
+	smu->cpu_actual_soft_min_freq = 0;
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
