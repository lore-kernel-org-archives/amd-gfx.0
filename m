Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED098C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B604F23BA7
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B604F23BA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1944B89CE2;
	Sat, 19 Dec 2020 00:49:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790C289CE2
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEcSw2ksuWkZfVbyWXiDwwiOBgOPVuuEdmfIxL6FNpYFWIoZxoejvzl4ZYkEx/gVx8iZAq5KNjVycKRs68wkcQ+eov/Et4xfHDCvaKX1OB2EbS0scqez8en/7tY851DKCSXrjPxwCCl9gVtzGgeZejICYl6CbGz272S/oRnaQItf7ecNvqePhozqCQjRUU3vFg+4a5i44Kpv6kLHOPoetN5TXmI7pudOSyf+B4tQZsCwxT8nIWurCR/5/fjJxvz4akgCAKATDbixw+DL268fm3r7YIBfLkD61zK9kqKD3RkKLT+cyLdWQw43ACcADBlfxo081HwoaMRGztv5TE7CRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXPNLnH7ZWxZl0SYlgWwBadcFoLhsKypRyw8Ga/Vc2c=;
 b=jWVYiFTcpmPBMPxnREhx6xaBbIeHUwTCMXtgtucn9BEf40teteG8kYCVQga1eM8Wt0jwr8gp0KapgZNZ5abx1uE0zNWkSGIEE4736x3n+peJ30jemsvIbit22pPsoVktYjDg+laKtlbsbbsheVOz1x91jNZAawjpYWCVhpMrX1i66bDqlqEU2IPqx5CasW7xM5ITpV6R6Ebu+7NDGbf2mGBVPX88giAPy4QyNfE9SsZACc+fOwS6O7D2BCA738d9PIg1BEd0+l3S5LNlUIP4EBi6K7dk/amOYXoInPSR45JBPHvalSMWiw5X2X1ONk/JPCpyelOU+YvRkxEaLkWyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXPNLnH7ZWxZl0SYlgWwBadcFoLhsKypRyw8Ga/Vc2c=;
 b=QMCIQ/2xe1ed1dU62t/6+dl4FNsgVDWzevQDVmQdR1SFxu8yAcbw+3aVdk0MiGk6XgiP+969szdscOeXvyxOd0X5OwRHVXtjAeVps8j2EhM5bcmyRjej/mpupB1ryL0sMJuu2el20zJUymHmKCLYnFKK5USmN++p89UoBPq04w0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:10 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:10 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] amdgpu/pm: Powerplay API for smu ,
 updates to some pm functions
Date: Fri, 18 Dec 2020 19:48:31 -0500
Message-Id: <20201219004831.13527-9-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c91dbd33-b811-4961-bba4-08d8a3b7e618
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB32799F41925E1092DAC4EF83F0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PARCyMc7xbGXwBWrdIVntVB4J5nkICxmfrb2tyBjC/Mqj+VogHGne7sL1d4Z6UmCEyp+yzEmzOm3Ass0fZKGZrf2XpGxC2tdSLwQk2ppGHsbtPUJ9mVRZobLVidXc62TR2Mb+7NFUTidKPqfgOtOjaong7ejjxvPWdbD+XyL/c3tEV3Ek8qxwNdPJo8ToS49TMYCv21JB6R6vot9o9dDszA5DS4FUA0ckTEHn2KFPzUJ4LYXA73BpU9ZIY/P82+Re4n89REymtwFjlEal3HbAHkIxwNvKka3NvsiyUngmdgDTvKlqbB9mx/gA5QjC2vxA2SR4S0b8fEUl1P7bSITT5OQxB4WdpHQpu/n3LNhC63KXxxUBKPvss1eBs981EB7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kc2hAVUMu8ShURQiK4SKwKY84NomikSzJKionhZNFIGQakbFzoczQ+rnMHXw?=
 =?us-ascii?Q?7uUn0fzMp/7dLJjeNxcSoDUZlqYiqWgdOnuKOPOl1K7wpy6F5b4m0vMw4nVP?=
 =?us-ascii?Q?QF9/wwUcvfWUNIajd4dSLP9w790GD9VPF4wbTRD3jahA19yJihGBYkQtvBAZ?=
 =?us-ascii?Q?5Vv7luoZ1Tm2+tIB5twqsLrKtFidFH7SvnnSO3AlPvYB/17XtshAvgIKfCqJ?=
 =?us-ascii?Q?KK5SKOWkGl16ewK7xPExdbWfJXfoen/4Iy43wRsG7uZIq5wZRpvGQd3UWdvd?=
 =?us-ascii?Q?s3UYQzIxj/l8cwk2x5bXR0+7cOlmTGAcJ2gctH1h//fuu9JhPgGKWPVfKDSn?=
 =?us-ascii?Q?kKw92QwJMzhW8HasIoLzlTY4/5zeQKBXZhVsFtDseEaptd+4Q7OxQT2S/Rxm?=
 =?us-ascii?Q?uil0WZLUo3GSdTsdj6yRs8UoDkY9kgGnKjBtyDxR3z1Xk12YtZ4o0jUN3y25?=
 =?us-ascii?Q?AdUScQNH53xa7Vnej4WfnVnZ5aUpulCNXGygkZCK/Bb2VIIuhifrLwY5NRjO?=
 =?us-ascii?Q?hO/6XUviFxTfh89pmSHzOz1u4d+3VCUtHwEd++TQwJD/09k7CSGVBiQpo92+?=
 =?us-ascii?Q?atFlo7obGftOdZ0WGAner1B0Zb4fAm+q+Jr+rMccSXRF5pvk8g83cZbQ2LEN?=
 =?us-ascii?Q?/erss5SZq1VSV4CzyB52vlAbUJYK/BfAZnt20EaYoDcayo92HD60aVx8nYWd?=
 =?us-ascii?Q?HqG3kThBk5w55fRTPtMdCMOfxochxMhCDL4qlo636ZWwLRvnz1J900IKdreM?=
 =?us-ascii?Q?VOfABvkjOfgeVBoghRG2KAVhSb5gISadQ0I4aE9hnWRAhgVqEu+ckrcoNnLH?=
 =?us-ascii?Q?j5VhsN2mRHcDFFG6GhkwprXIQ8NJAntm1YH7M9ktoVC/xrBm4UCu9guHhKqv?=
 =?us-ascii?Q?SeBf//DcDTKA1QDQt+EHFWx4FilqPiLlZWHID+uLWOL0NR7my+Vgt2aiSPvp?=
 =?us-ascii?Q?LdNOR/+zkM/3fbsqhZCKdt0QLAlaGcfbij6oTvEOEN04bLNV7qWprZXxrKjv?=
 =?us-ascii?Q?Bk+0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:10.6489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c91dbd33-b811-4961-bba4-08d8a3b7e618
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1ZeUzmx/OE5vaOQ5E5R1oFTcCGLd258Fl3W8BLxsWV7/HSqf6YepWSKZ20sE3y4JySOV7t56AiBdr3Dvq+hXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modified Functions
  smu_sys_set_pp_table()        - modifed signature to match Powerplay API set_pp_table
  smu_force_performance_level() - modifed arg0 to match Powerplay API force_performance_level
  smu_od_edit_dpm_table()       - modifed arg0 to match Powerplay API odn_edit_dpm_table

Other Changes
  smu_od_edit_dpm_table()       - removed call to task(READJUST_POWER_STATE) after COMMIT_TABLE,
                                  now handled in calling function
  amdgpu_set_power_dpm_force_performance_level() - now checks thermal for swsmu systems before trying to change level
  amdgpu_set_pp_od_clk_voltage() - now attempts to set fine_grain_clock_vol before swsmu edit dpm table

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 94 ++++++++---------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 17 ++--
 3 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b84b14dc3eb9..de89f7d895ee 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -369,14 +369,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_force_performance_level(&adev->smu, level);
-		if (ret) {
-			pm_runtime_mark_last_busy(ddev->dev);
-			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
-		}
-	} else if (pp_funcs->force_performance_level) {
+	if (pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
 			mutex_unlock(&adev->pm.mutex);
@@ -619,15 +612,12 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_sys_set_pp_table(&adev->smu, (void *)buf, count);
-		if (ret) {
-			pm_runtime_mark_last_busy(ddev->dev);
-			pm_runtime_put_autosuspend(ddev->dev);
-			return ret;
-		}
-	} else if (adev->powerplay.pp_funcs->set_pp_table)
-		amdgpu_dpm_set_pp_table(adev, buf, count);
+	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
+	if (ret) {
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -807,53 +797,42 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_od_edit_dpm_table(&adev->smu, type,
-					    parameter, parameter_size);
-
+	if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
+		ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
+							parameter,
+							parameter_size);
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
 			return -EINVAL;
 		}
-	} else {
-
-		if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
-			ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
-								parameter,
-								parameter_size);
-			if (ret) {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
-		}
+	}
 
-		if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
-			ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
-						parameter, parameter_size);
-			if (ret) {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
+	if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
+		ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
+						    parameter, parameter_size);
+		if (ret) {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
 		}
+	}
 
-		if (type == PP_OD_COMMIT_DPM_TABLE) {
-			if (adev->powerplay.pp_funcs->dispatch_tasks) {
-				amdgpu_dpm_dispatch_task(adev,
-						AMD_PP_TASK_READJUST_POWER_STATE,
-						NULL);
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return count;
-			} else {
-				pm_runtime_mark_last_busy(ddev->dev);
-				pm_runtime_put_autosuspend(ddev->dev);
-				return -EINVAL;
-			}
+	if (type == PP_OD_COMMIT_DPM_TABLE) {
+		if (adev->powerplay.pp_funcs->dispatch_tasks) {
+			amdgpu_dpm_dispatch_task(adev,
+						 AMD_PP_TASK_READJUST_POWER_STATE,
+						 NULL);
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return count;
+		} else {
+			pm_runtime_mark_last_busy(ddev->dev);
+			pm_runtime_put_autosuspend(ddev->dev);
+			return -EINVAL;
 		}
 	}
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -878,12 +857,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		size = smu_print_ppclk_levels(&adev->smu, OD_SCLK, buf);
-		size += smu_print_ppclk_levels(&adev->smu, OD_MCLK, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_VDDC_CURVE, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_RANGE, buf+size);
-	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
+	if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index edd911ac8e5a..f5a6246bb6c4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -664,7 +664,7 @@ int smu_get_power_limit(void *handle, uint32_t *limit, bool max_setting);
 int smu_set_power_limit(void *handle, uint32_t limit);
 int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
 
-int smu_od_edit_dpm_table(struct smu_context *smu,
+int smu_od_edit_dpm_table(void *handle,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
@@ -715,7 +715,7 @@ extern const struct amdgpu_ip_block_version smu_v12_0_ip_block;
 bool is_support_sw_smu(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_sys_get_pp_table(void *handle, char **table);
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);
 int smu_get_power_num_states(void *handle, struct pp_states_info *state_info);
 enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
@@ -745,7 +745,7 @@ u32 smu_get_sclk(void *handle, bool low);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 int smu_sys_get_pp_feature_mask(void *handle, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2f5a5b2b1f2b..3742b5c0a4bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -345,8 +345,9 @@ int smu_sys_get_pp_table(void *handle, char **table)
 	return powerplay_table_size;
 }
 
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size)
 {
+	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret = 0;
@@ -1648,8 +1649,9 @@ enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 	return level;
 }
 
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int ret = 0;
 
@@ -2075,10 +2077,11 @@ int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
 	return smu_print_smuclk_levels(smu, clk_type, buf);
 }
 
-int smu_od_edit_dpm_table(struct smu_context *smu,
+int smu_od_edit_dpm_table(void *handle,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2088,11 +2091,6 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 
 	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
-		if (!ret && (type == PP_OD_COMMIT_DPM_TABLE))
-			ret = smu_handle_task(smu,
-					      smu->smu_dpm.dpm_level,
-					      AMD_PP_TASK_READJUST_POWER_STATE,
-					      false);
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2731,6 +2729,7 @@ static const struct amd_pm_funcs swsmu_dpm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
@@ -2738,12 +2737,14 @@ static const struct amd_pm_funcs swsmu_dpm_funcs = {
 	.set_fan_speed_rpm       = smu_set_fan_speed_rpm,
 	.get_pp_num_states       = smu_get_power_num_states,
 	.get_pp_table            = smu_sys_get_pp_table,
+	.set_pp_table            = smu_sys_set_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
 	.dispatch_tasks          = smu_handle_dpm_task,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
 	.get_power_limit         = smu_get_power_limit,
+	.odn_edit_dpm_table      = smu_od_edit_dpm_table,
 	.set_mp1_state           = smu_set_mp1_state,
 	/* export to DC */
 	.get_sclk                = smu_get_sclk,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
