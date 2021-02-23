Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EE7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359CA64DF3
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 04:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359CA64DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0731689DA8;
	Tue, 23 Feb 2021 04:21:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8629689E59
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 04:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibvc349g53yef/VhF3NeQRxyp9mtW8GwO6KEiU7Ub1CHCF0UJ694rSZ/+vLasytFwjLMXGWMKTJiRgeTF0JuwoMOV1gtZsfZH7otJo8oq+z5rT6MpAWEaGpccb6w0iVuIjO7n+f2jANyypbymITx3/L6Az7W91aHEzNrtejjGNTt29/hE9Q8+AHi/GG6t8UW3Lm/deXmkmYnDgJMKeWXJT/k6vtp4OjS3vHEirngiMGaNSzbVtCvGOPgF1LjZvcu4AUQGxca3RKaBCntmojomR/HizGgGAJp75ZxHAEvq2nqcPo5IJUfsttG2Msgqx+hoy8AR2Kxz8GyBTxvqPHdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GJ+zOYk4imK1SrNhKiJoJDAXf/J0AlAqlq/MnlPBoo=;
 b=lG7UBSsVvkANPX4Bc9JR4uAfl7pakPz0uFl7ksliee42bm8kgD+CDKNkPNPSlXkXaguxnwaiJygrz6mSUzZaYH0T/4g2O7a2vehy0mRjDenJZ40jIcq2+7iOCQ0nPzPz41nYY1Edlp8VfA33E4JAk0sfzRKRWwxGJc2I3weWJUXiozQBINYm4XR/GBFOgrQxoVEUfP/TRriWWnbF0xxVxHCtKGIx8m9Kb/A4NWaMpDyd9bTdqJSC4fTe6Bx4wwDK9XkKUCLfblcU3QKLOMUeAVL7adp40qijPOz7DL3pwjQ2jlYKWy0h0uGDrhHyXlFFKVoMuNouyWHw7xA8cREgzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GJ+zOYk4imK1SrNhKiJoJDAXf/J0AlAqlq/MnlPBoo=;
 b=cncftIjrguNEUxGsd3//zUpmtnq/vHS2LnE35uM4WgdMlTWKafTmGBRz+IdVZWK/N/evIDGBHRgKB3YcTkXmfPS4ny3qnsAuaDOn2+Zv89vQ4doxzXMGLZeUpO12g7oZIEyv1W6E/TqzZlkdKg6AHbVMGlyYtQHqN6laTTeJPf4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 04:21:44 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3846.039; Tue, 23 Feb 2021
 04:21:44 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] amdgpu/pm: Powerplay API for smu ,
 updates to some pm functions
Date: Mon, 22 Feb 2021 23:20:32 -0500
Message-Id: <20210223042032.3078-9-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223042032.3078-1-darren.powell@amd.com>
References: <20210223042032.3078-1-darren.powell@amd.com>
X-Originating-IP: [142.126.154.129]
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.154.129) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.30 via Frontend Transport; Tue, 23 Feb 2021 04:21:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a5ee878-353c-4c90-9c7e-08d8d7b286c2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1850C9E4B9124048A4AA6384F0809@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3FIUOAwufV8tTAu+s9OaxpGPusHR9hOmWJuVHH2b01TFvYFdrGQ8jeHtCrPjQvHAWmB8JMDIgX1Lk/SkeBeHQeVyn+AXukFO2yWEgWvi6tu8r4zbVeNoZW69VpM36fOxQGAbs1puoMV+k410x1pY56y3Zonv+pQG7C2l9kVjf16J2W0RG+dfD6/kQZAtzzSVWscpqizVE64CQ9Sfq6yDitUUL5ZMRs50+xYEKanHmHNrRmI3F56j3uHsTg4dz3/t/x5f+wEpfCvxIcqr67m11i1zXGds65P6K1g/DAlIssxpOLLKerolp3x+zBel58d2SvJzDQjmSqxVlwBW5paiE/M+MKPWdU27j+DXz75SDq0Z6PI6qTRpXWkLtAfcPquakIceVkKx/HHgXCJgtaJ/TuwwrepTeI6X4JXTszbT31jw22samGUKmdBgVEUNDd7YlvntWYc4QdUC0fvWo1zWtVakvc48WPmy20ZEtkZDcsvg5PtAl/DyFEkfkPbbMhJbTYB2L1UP4aeRvyh1bZPYFsP3O9vJQSwV4Y4Yjr9YY+UL37Tplsobx37Nzk5ZcEtG94eqR3hyOwkrnRJwO8Ufg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(4326008)(956004)(6506007)(26005)(5660300002)(16526019)(316002)(186003)(8936002)(6512007)(2616005)(66476007)(66946007)(36756003)(2906002)(15650500001)(83380400001)(6916009)(69590400012)(30864003)(66556008)(1076003)(52116002)(86362001)(6666004)(478600001)(8676002)(6486002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IOqnPHCKmtSfoCRtEqZFTFUHWBs4SeUZQxs4yxX/m8NOdLMf0aoD7rlNw+sc?=
 =?us-ascii?Q?mkF6dPJCcv2fLlRxBqwRNi//LRHS0nhI4bhMu0eRr1A6GTm8VUY/nqb8/k0w?=
 =?us-ascii?Q?m3tR0znG0qVrXbgRJYSUZJ/LZGlZYgXFW/uxlguTNu4GQ522Q1T6BqvqpdIw?=
 =?us-ascii?Q?PT/yh6h3M+urKQxOTALO1iwNtIEC/R/pRI01YMOFLFGbbU9EJ0LExOTQuveU?=
 =?us-ascii?Q?1xhTr9RD7GpyVA0vagRVc+1BvCZCx1O746Dm4XyASIxeKoKXhtGt1PmclKUJ?=
 =?us-ascii?Q?fpZNiMnPntU4KouAxoGIEQJLCYn7+du9A/Sj8L/zImHCH4wKb2ZLWXTHE67+?=
 =?us-ascii?Q?jyqPftN3iXMvbltkPIzImqAvsvVEM0/1u+NJsVrgbwyNu9KOGHPKPOM7jAys?=
 =?us-ascii?Q?fvdbFYcRfOcRVSWvH0LGZr4WAyxK6N0RpauN2Qu7YgXJau0ivk9gRPqGSqSq?=
 =?us-ascii?Q?LZZwfBaNlwEZOi0BK91pFC/UyU6bQvEzertGYZ9rYUy6SZ4f7BfeHp0y4j7L?=
 =?us-ascii?Q?3auJe9dCIetlx+Iqce09SqFLIlfKYScXOwXCznfLAk3/HT+6gpAf2sbXd3lB?=
 =?us-ascii?Q?ulCJjFtapmRU+OXZ9osWRxNvlVmLHBRnojMMahg5oknV7BNrDJhv/Q0jcCos?=
 =?us-ascii?Q?pLHQRSAlx8wAg4dUHsrUQx1S6WnvCbhdMwFYYIQqFbr8D2EgI5VC4kEXOjOn?=
 =?us-ascii?Q?e8aSkGawrwUEfrfvB5O8QccA/Lj3N+HEdUp+TJ7kL4Dx6CliLX4EIHkxzDy6?=
 =?us-ascii?Q?xGv1jEbzmPGBKF1dEZhDPggDsoLY5ExCfuHRKuoxiiP2yFsxTXEA5XkVHekD?=
 =?us-ascii?Q?LZXOK+aERULi6xJzbuvl84kWmaI8Pwvtnw/RJ9LlLLeM2DSwua7Rc/cih4Dm?=
 =?us-ascii?Q?ohiQuM9saf+C/C8jCiSGD5bSGjiRqkaOoo718X3dxFuzmA4zM3IHn3RQAsRp?=
 =?us-ascii?Q?YHt3pkn97yXrCLEhsya6Bljrpom/dZPyJkPelVrvxMKqONH9TwCFjNXrPQQU?=
 =?us-ascii?Q?7nDovs31E2HWYhhsNofE6F3WNmiJbRi/2KD3GRXsoso3gd2PeKG9TrDIacmD?=
 =?us-ascii?Q?/kfJrHUePKXVHPpetlSkvxHbXxXczTfSPsls1vUiZqiPvLQuxG33QK7XhRNh?=
 =?us-ascii?Q?dTPpTYbmvDjyg96Ffss45SywLc8+Lbd0qj019Tm6LlN2ne+AVb8zw0cALXFD?=
 =?us-ascii?Q?oBc1mBOBm93BZIAJzqPORtBUpOP1KWNeydjH0A+o5v0GFOJ0f0tE5PtPiEmn?=
 =?us-ascii?Q?mJhh+ctxMDqP7Pz71UiVnkRodhepnj9/kcydXlAzTWwrhE345tsgUDFouNH7?=
 =?us-ascii?Q?U6qGLNRvIXgfCPsFa40VOvS2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5ee878-353c-4c90-9c7e-08d8d7b286c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 04:21:43.9685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9D+Uga/MBQ1Am4dS3jRJ3fR3CamUigX20kVVmIoHXahf6E27bShBGfQzn4Pe46/JgDIV2IZ5ItgB1KWSnErO6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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

v3: updated to include new clocks od_vddgfx_offset, od_cclk
    Context mismatch with revision v3 to patch 0003

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
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        | 98 +++++++++--------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 17 ++--
 3 files changed, 48 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ec5277ed74f7..1675a5e72a0d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -370,14 +370,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
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
@@ -615,15 +608,12 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
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
@@ -821,53 +811,42 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
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
 
@@ -892,18 +871,13 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		size = smu_print_ppclk_levels(&adev->smu, OD_SCLK, buf);
-		size += smu_print_ppclk_levels(&adev->smu, OD_MCLK, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_VDDC_CURVE, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_VDDGFX_OFFSET, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_RANGE, buf+size);
-		size += smu_print_ppclk_levels(&adev->smu, OD_CCLK, buf+size);
-	} else if (adev->powerplay.pp_funcs->print_clock_levels) {
+	if (adev->powerplay.pp_funcs->print_clock_levels) {
 		size = amdgpu_dpm_print_clock_levels(adev, OD_SCLK, buf);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_MCLK, buf+size);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDC_CURVE, buf+size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_VDDGFX_OFFSET, buf+size);
 		size += amdgpu_dpm_print_clock_levels(adev, OD_RANGE, buf+size);
+		size += amdgpu_dpm_print_clock_levels(adev, OD_CCLK, buf+size);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index a2f4b8f1db4e..af71c7c6db46 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1242,7 +1242,7 @@ int smu_get_power_limit(struct smu_context *smu,
 int smu_set_power_limit(void *handle, uint32_t limit);
 int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
 
-int smu_od_edit_dpm_table(struct smu_context *smu,
+int smu_od_edit_dpm_table(void *handle,
 			  enum PP_OD_DPM_TABLE_COMMAND type,
 			  long *input, uint32_t size);
 
@@ -1294,7 +1294,7 @@ bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
 int smu_reset(struct smu_context *smu);
 int smu_sys_get_pp_table(void *handle, char **table);
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size);
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);
 int smu_get_power_num_states(void *handle, struct pp_states_info *state_info);
 enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
@@ -1324,7 +1324,7 @@ u32 smu_get_sclk(void *handle, bool low);
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
 enum amd_dpm_forced_level smu_get_performance_level(void *handle);
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level);
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 int smu_set_ac_dc(struct smu_context *smu);
 int smu_sys_get_pp_feature_mask(void *handle, char *buf);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 72501d8a80b9..f5d9590f2178 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -477,8 +477,9 @@ int smu_sys_get_pp_table(void *handle, char **table)
 	return powerplay_table_size;
 }
 
-int smu_sys_set_pp_table(struct smu_context *smu,  void *buf, size_t size)
+int smu_sys_set_pp_table(void *handle, const char *buf, size_t size)
 {
+	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	ATOM_COMMON_TABLE_HEADER *header = (ATOM_COMMON_TABLE_HEADER *)buf;
 	int ret = 0;
@@ -1775,8 +1776,9 @@ enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 	return level;
 }
 
-int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_level level)
+int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int ret = 0;
 
@@ -2278,10 +2280,11 @@ int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
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
@@ -2291,11 +2294,6 @@ int smu_od_edit_dpm_table(struct smu_context *smu,
 
 	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
-		if (!ret && (type == PP_OD_COMMIT_DPM_TABLE))
-			ret = smu_handle_task(smu,
-					      smu->smu_dpm.dpm_level,
-					      AMD_PP_TASK_READJUST_POWER_STATE,
-					      false);
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2950,6 +2948,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_percent   = smu_set_fan_speed_percent,
 	.get_fan_speed_percent   = smu_get_fan_speed_percent,
+	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
@@ -2957,11 +2956,13 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.set_fan_speed_rpm       = smu_set_fan_speed_rpm,
 	.get_pp_num_states       = smu_get_power_num_states,
 	.get_pp_table            = smu_sys_get_pp_table,
+	.set_pp_table            = smu_sys_set_pp_table,
 	.switch_power_profile    = smu_switch_power_profile,
 	/* export to amdgpu */
 	.dispatch_tasks          = smu_handle_dpm_task,
 	.set_powergating_by_smu  = smu_dpm_set_power_gate,
 	.set_power_limit         = smu_set_power_limit,
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
