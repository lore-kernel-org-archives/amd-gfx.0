Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE9BC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDDF20720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w4ZR+PCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDDF20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0EA6EB73;
	Fri, 10 Jul 2020 04:48:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FE96EB73
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enwffeQQKY/syFCXYf1aH3wdkFhyRoZOrucjb5SaPwnWDeNyC+lzJ/eM9skuB/HW9CNEHg9BGPeW87Yy/VZ1lIpMHCCOfJYJRgHLcyr62e9KGsXY6MrBre219knNHOAZ14AJbYgQMdgTO1kJ9uFoSOhiBfHeGxdDWR8CctoftRAzQsxsrAwvrrBju1KmLfZevGYI0395zEhj/TGH7XFgRbOwJxlwtf978Rtmjy9D98IVoy5X7Q9+6CjVYLDD7W8VxP51EZm8ufRkIT1vSNEP+DQRqDuoaIbrcFVorMjzp3PoEvUhqF6Ql+cRwN3WEnEd3/a9D28JUkyW3ETEPUcbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI0ynystYkCi30H8Gl3Z3qJLoKXsMAdMC33mTgUzIrQ=;
 b=ZjmD1fKpG8+gA6e5Z3JynO+H6yNReaYSQuiuA6BENuATdI3EQTT5iO7ewSC4J+nypvofReji5pa5+jguVvP37fLiEcHV0B6okhe1GiagH7ehh6ylGPSspMtFxtqb+A5ow9CZJ20jc8ARszHZHxn1eNkL4q68Q+eteHNDsSg/eNb6U6ABr/Y147epVrYCRxoXGVavsw6EThPAqVOwCNIMlPXYM+D6V3WNMJm+TFC70ufDLOOU5801E8CL32l2eyhzWaH5rKaG97Jd0ztaQTt46N5SxWQrhPh5EsX8nqxD06uD85lvdz98e4mCt8z/FzOCAQizgA4yAgShQ2nXlEFGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI0ynystYkCi30H8Gl3Z3qJLoKXsMAdMC33mTgUzIrQ=;
 b=w4ZR+PCqAQpRkga0Hkajuu6L9bfNg75RjUNGp7M8mBl2nyNGrWpwWJq5MdQciJuIbMwDlJh5zf+bva7i52+P0cLEwgpf+Vw9ANauTDZZjDcNbDfuFobJuhnQEQy1qvX4nZzkpY0BHikup9Em5KNCJhQCaUcUxNfbppn/3PknDuw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/16] drm/amd/powerplay: drop unused APIs and parameters
Date: Fri, 10 Jul 2020 12:47:46 +0800
Message-Id: <20200710044746.23538-16-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:36 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9559819-dbdc-4f8a-bdd2-08d8248c8263
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23609DD10862E97197F256C9E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMoV/F6bE7eGTTJZTN4q3+cEt27m+EXwZ6ufvd33hEDZgL/5XWHAV4qW6ONAFtdBkiyb4xR1BOAF/Z5iqmTAVoZuw+hvvJbITgcatiDdcoa6q/OXNBjyChEY2A1PQfgHDhHpx2tJHqaOOeZDQbGNTnM/SPCL+B4Un8CXa3HRwvO/3BHKtwpOq0+bBuYFJh0NxfzgysYSzR7mfe5doLbtiP/CdACqrc0LsExdZy+VxJ2rp40QD1Qigpj0cEih2ne1OP/8Ob2qozXd6Rctx5++wKKzytZW+Ri29omUHruadVxjRZsaq6dTvAo7+hn/cPNp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SnzC9wgn0Z7co+lvJFzZo9qYbWoUq5brBb6xPWVZrOKM+DpLCkR53Q4kmnLHlMynyvFhjMirALKIhYYCxQXda/hUFas1brxTtHpbAmI9Hh+k0xsdUZk1diwALuJT+XirbCPe3WJpYehP+kHvXfTVCMQmAwYluFWqVMWMyUtCNqN9LvtLsxDS3hMNJcmA1Y/mF7qAYOXtLiAVWRmO83CVgtu2/50VM82VfLx4j70B73kl/k5BYdVVbrmNQ5Ue7SQLvt8PPnGdMbDb2/4efP6kaoScgfbtwJoiNNhZAGpP7WMqDZFgksUqQgIKStDPZuSgiJ474AO5adI+OYQxjw/hRH0+F2bsvux0SEiIMxesjGR19EPcKkl6bSSscO18OWSQ7HwOBjPNZMvsrE6Yv4ecXJjqjpNxifiOjumuLkn3qe+mrTAsXA2N0lFhYLQua5e6Qg5g8BDj4PcXE4c/uJ5L/gYcOrDF1DQoPQDeaz2oZUKxiqCXC0VTss3QnHs+kMBM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9559819-dbdc-4f8a-bdd2-08d8248c8263
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:37.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4dP31rV6tfusdijNz5K6XquISA4cTQK37xssPeEfPyj55+Z0U3NiiuyMZB8GYbd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

Leftover of previous performance level setting cleanups.

Change-Id: Idddc4adce365b34eacbc13f75cc0629859c6d412
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c         | 12 ++++++------
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  9 +++------
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 12 +-----------
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c     |  2 --
 drivers/gpu/drm/amd/powerplay/smu_internal.h   |  5 -----
 5 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index d2401379bd33..20f39aa04fb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1105,7 +1105,7 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask, true);
+		ret = smu_force_clk_levels(&adev->smu, SMU_SCLK, mask);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
 
@@ -1173,7 +1173,7 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask, true);
+		ret = smu_force_clk_levels(&adev->smu, SMU_MCLK, mask);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
 
@@ -1241,7 +1241,7 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask, true);
+		ret = smu_force_clk_levels(&adev->smu, SMU_SOCCLK, mask);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_SOCCLK, mask);
 	else
@@ -1311,7 +1311,7 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask, true);
+		ret = smu_force_clk_levels(&adev->smu, SMU_FCLK, mask);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_FCLK, mask);
 	else
@@ -1381,7 +1381,7 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask, true);
+		ret = smu_force_clk_levels(&adev->smu, SMU_DCEFCLK, mask);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_DCEFCLK, mask);
 	else
@@ -1451,7 +1451,7 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
 	}
 
 	if (is_support_sw_smu(adev))
-		ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask, true);
+		ret = smu_force_clk_levels(&adev->smu, SMU_PCIE, mask);
 	else if (adev->powerplay.pp_funcs->force_clock_level)
 		ret = amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
 	else
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4080b3c792ac..38b3b47d12b7 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1764,8 +1764,7 @@ int smu_set_display_count(struct smu_context *smu, uint32_t count)
 
 int smu_force_clk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
-			 uint32_t mask,
-			 bool lock_needed)
+			 uint32_t mask)
 {
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int ret = 0;
@@ -1778,14 +1777,12 @@ int smu_force_clk_levels(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	if (lock_needed)
-		mutex_lock(&smu->mutex);
+	mutex_lock(&smu->mutex);
 
 	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels)
 		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
 
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
+	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 91c8b69da026..470b0377a860 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -476,13 +476,6 @@ struct pptable_funcs {
 	int (*display_config_changed)(struct smu_context *smu);
 	int (*apply_clocks_adjust_rules)(struct smu_context *smu);
 	int (*notify_smc_display_config)(struct smu_context *smu);
-	int (*force_dpm_limit_value)(struct smu_context *smu, bool highest);
-	int (*unforce_dpm_levels)(struct smu_context *smu);
-	int (*get_profiling_clk_mask)(struct smu_context *smu,
-				      enum amd_dpm_forced_level level,
-				      uint32_t *sclk_mask,
-				      uint32_t *mclk_mask,
-				      uint32_t *soc_mask);
 	int (*set_cpu_power_state)(struct smu_context *smu);
 	bool (*is_dpm_running)(struct smu_context *smu);
 	int (*tables_init)(struct smu_context *smu, struct smu_table *tables);
@@ -498,8 +491,6 @@ struct pptable_funcs {
 	int (*display_disable_memory_clock_switch)(struct smu_context *smu, bool disable_memory_clock_switch);
 	void (*dump_pptable)(struct smu_context *smu);
 	int (*get_power_limit)(struct smu_context *smu);
-	int (*get_dpm_clk_limited)(struct smu_context *smu, enum smu_clk_type clk_type,
-				   uint32_t dpm_level, uint32_t *freq);
 	int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
 	int (*allow_xgmi_power_down)(struct smu_context *smu, bool en);
 	int (*update_pcie_parameters)(struct smu_context *smu, uint32_t pcie_gen_cap, uint32_t pcie_width_cap);
@@ -745,8 +736,7 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
 int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
 int smu_force_clk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
-			 uint32_t mask,
-			 bool lock_needed);
+			 uint32_t mask);
 int smu_set_mp1_state(struct smu_context *smu,
 		      enum pp_mp1_state mp1_state);
 int smu_set_df_cstate(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 5b76d67d03d7..866ae014eda2 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -1041,13 +1041,11 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_smu_table_index = renoir_get_smu_table_index,
 	.tables_init = renoir_tables_init,
 	.set_power_state = NULL,
-	.get_dpm_clk_limited = renoir_get_dpm_clk_limited,
 	.print_clk_levels = renoir_print_clk_levels,
 	.get_current_power_state = renoir_get_current_power_state,
 	.dpm_set_vcn_enable = renoir_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = renoir_dpm_set_jpeg_enable,
 	.get_workload_type = renoir_get_workload_type,
-	.get_profiling_clk_mask = renoir_get_profiling_clk_mask,
 	.force_clk_levels = renoir_force_clk_levels,
 	.set_power_profile_mode = renoir_set_power_profile_mode,
 	.set_performance_level = renoir_set_performance_level,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 91d3965bbe80..727498a6e76d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -68,8 +68,6 @@
 #define smu_display_config_changed(smu)					smu_ppt_funcs(display_config_changed, 0 , smu)
 #define smu_apply_clocks_adjust_rules(smu)				smu_ppt_funcs(apply_clocks_adjust_rules, 0, smu)
 #define smu_notify_smc_display_config(smu)				smu_ppt_funcs(notify_smc_display_config, 0, smu)
-#define smu_force_dpm_limit_value(smu, highest)				smu_ppt_funcs(force_dpm_limit_value, 0, smu, highest)
-#define smu_unforce_dpm_levels(smu)					smu_ppt_funcs(unforce_dpm_levels, 0, smu)
 #define smu_set_cpu_power_state(smu)					smu_ppt_funcs(set_cpu_power_state, 0, smu)
 #define smu_msg_get_index(smu, msg)					smu_ppt_funcs(get_smu_msg_index, -EINVAL, smu, msg)
 #define smu_clk_get_index(smu, clk)					smu_ppt_funcs(get_smu_clk_index, -EINVAL, smu, clk)
@@ -92,7 +90,6 @@
 #define smu_get_dpm_ultimate_freq(smu, param, min, max)			smu_ppt_funcs(get_dpm_ultimate_freq, 0, smu, param, min, max)
 #define smu_asic_set_performance_level(smu, level)			smu_ppt_funcs(set_performance_level, -EINVAL, smu, level)
 #define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
-#define smu_get_dpm_clk_limited(smu, clk_type, dpm_level, freq)		smu_ppt_funcs(get_dpm_clk_limited, -EINVAL, smu, clk_type, dpm_level, freq)
 #define smu_override_pcie_parameters(smu)				smu_ppt_funcs(override_pcie_parameters, 0, smu)
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
 #define smu_set_thermal_range(smu, range)				smu_ppt_funcs(set_thermal_range, 0, smu, range)
@@ -103,7 +100,5 @@
 #define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
 #define smu_get_asic_power_limits(smu)					smu_ppt_funcs(get_power_limit, 0, smu)
-#define smu_get_profiling_clk_mask(smu, level, sclk_mask, mclk_mask, soc_mask) \
-	smu_ppt_funcs(get_profiling_clk_mask, 0, smu, level, sclk_mask, mclk_mask, soc_mask)
 
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
