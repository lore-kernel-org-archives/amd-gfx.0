Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DDC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 07:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5CE207F7
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 07:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tTQh3lni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5CE207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DC46E321;
	Mon, 28 Sep 2020 07:16:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760057.outbound.protection.outlook.com [40.107.76.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28FF6E321
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 07:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbnFfPIuuzgb3CbZ2WL6AJyx+iCI9iiu6mAB98spiHx5fdC+ALoi0u1zmaGu2YFBwOQkRURc/U0brezwyDyl5LdPL8lHjk/zf6VrY7NMnqnRR5mff1YFXGwj6uwgURCFFSaAz38bnGQDaDJNI20BOZNqzwFtxoVvU8i3waI7FvVExmRuxdEsM8CeQZuT2o2jSdaBT4YIOuaBDvYohoGK0ceAlGpJQc1xm2R4OcrsrtgnQ4D4hz2Pxi7rs8wCe9QdfDNhE6HaGxxvZFWnL2yXAQjgnjXJrEB/YWbz+JC7RFOjFCBeGnKjODwkjDIWcMy1jmUub9DgkFM4vyHmGyeDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czlVdZIorNIMFvjugraN0Qx7inLxx+hjN5nCf3PifsQ=;
 b=NXCphHB/80nSLheBFJb1Guw1fx/fObomzJmW9BIxHZz1HUt3k21qvLBkkLHuBwPImz1gJMg4voWh22Fm3601UEA2mMyywMmYTvZlW4aXasQ3wbKNJQk+8S/I+xE+7Z/nEerUqTQnzRqxRjISRIaeBCtJxslRVQwnf0BjwzT5WaFdcB6uwScsvpuvMJwUgSv60CJ/DVyBppi/+iWQqpzEhsjyvHwIm8a2VcPubsW9V/0OfhtN6UUBMnY1/vdhhcLhjHTjQcEV72VG5hG41XHBgxNh7HTgB4Ar5bngMygrl2CR2pNExISMx/zQO3x4JAYRQV34bkZhkkVVDFzuil94pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czlVdZIorNIMFvjugraN0Qx7inLxx+hjN5nCf3PifsQ=;
 b=tTQh3lni42OvmS3yGJ89Lx6DMtWYqG0ReOs391cqxWtqcLuApUzOP8+j780MoNIkR7xxDqVDJCYJaj6WyQHgj6Gmt+iEkS7v1ttpo3YyiHQkpnUwbAqmMQrRpgoUajpCrTQmyQN398x9bglXRP8KQzoV+bh3TagI5+iqszE7gyE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1920.namprd12.prod.outlook.com (2603:10b6:300:10e::20)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 07:16:33 +0000
Received: from MWHPR12MB1920.namprd12.prod.outlook.com
 ([fe80::e541:13a9:3217:1382]) by MWHPR12MB1920.namprd12.prod.outlook.com
 ([fe80::e541:13a9:3217:1382%12]) with mapi id 15.20.3412.029; Mon, 28 Sep
 2020 07:16:33 +0000
From: xiaojian.du@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: add one sysfs file -- "pp_od_clk_voltage"
 to support the feature to modify gfx engine clock(Mhz units) on
 Raven/Raven2/Picasso APU.
Date: Mon, 28 Sep 2020 15:15:30 +0800
Message-Id: <20200928071530.20244-1-xiaojian.du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0197.apcprd02.prod.outlook.com
 (2603:1096:201:21::33) To MWHPR12MB1920.namprd12.prod.outlook.com
 (2603:10b6:300:10e::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HK2PR02CA0197.apcprd02.prod.outlook.com (2603:1096:201:21::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 07:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b5290a4-a5f6-46a6-7c6a-08d8637e6d82
X-MS-TrafficTypeDiagnostic: MW3PR12MB4348:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB43480266543C0DDA5A1E9B29F1350@MW3PR12MB4348.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quIaMgYdFaqkc/ddd9weZ3yaPQAAsBC0fvVUg7bAbJI83s3oIuVq3YUIIxk/hGzrDlLhueLjUms3LSUFtfFZT2gmxVB0/GaxVakIsz3kjfmRznpNd6khOlIcwaDa0sTMf7ArBEc5cjHAlOO7kQQh0Ds8CsvHgsoMXr+VhycrXQYi/yplY5d3F3NoaPclUHPCLJ7P/Fb6TOpvjMFENtDvaJty0ejkHCsu6oXLMcHUub3R9HhuL83te79cdB0d/Yfd8q0S//eeTE80LxRe4J8U/4IkV39UQZePbYRBe7dq2PPsdpQta9SDqzIsxkpS6B03yVeebZLy9SpnvdR8nyfSgxVnTt4UlA09hf6vutpO1zgX3O5fwQAS5jJuH5kPYXP3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1920.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(83380400001)(2906002)(6916009)(1076003)(19627235002)(66556008)(66946007)(66476007)(30864003)(86362001)(5660300002)(36756003)(8936002)(316002)(2616005)(54906003)(956004)(478600001)(8676002)(6486002)(4326008)(16526019)(186003)(26005)(9686003)(52116002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9sxx+5iVxkX2fsB6wlQMrY5Wk2XHkyL7CORk85MzgeHRUfVW/WJkYiwV0W01SAV/Y7hTUMeEpZpMq/s7+WG+uowOyskFjBlD2bLkr4GIiGYMKTTjLhDT7kQtkLIAPkFW2tj+IhZQi2zsdB9objePVOzJDGyv/I+M7pQqKdEgMElaavd+J9Q3PlfExuKdAr3DobYlyiKmks2f2smGYb9EKUt9jLI7mQ+IMRJClHo8pWp7wBLlHcojrgL+ynv5ffBgtAQaxcLFeXn9mRkpcO7N4kmJp1mxqYT2CN8xnnGPtRdLCGB1pFuIH4/Aw+KYNLHTp+zJuEUA55vIvHLxir+dpSdECq2F7oSVtZfug8c0D+qOg163JtgG4XuezXjxMX9qL6x6ZPXAXYpVJCspcXUIhMGTpmjpkwFR949pYk5wBjvxvm59l5/jo2iey6FYt+oxyj0xxiCSRL4hOjnmwuPI9dNCdV1ifNEIwkkDIiDPzxa2+v7DobYWGYNVwZsmRGNu4D+Cq74GeT1EVg7DtyC+RjBr3oxEiCwdQldbW1dTDZOyY3kf/iNdPHWoP8W6nSI9gCqBaFYYhvzHP3RUcS17K9UTVxsU05TboU3mjPmEo7DSxgagz7Xh+/SoE5LkO6p4DalrZcPRWg9dIS6nC7NpAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5290a4-a5f6-46a6-7c6a-08d8637e6d82
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1920.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 07:16:33.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Uk0DyJMIasn0vZqzy0SoL6ODiBLhrcWXsfJKm0d66Isb7VdFkWyM6V/otTkB6iH2G0kRov5ILJbGKxHKgJhrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, kevin1.wang@amd.com,
 Xinmei.Huang@amd.com, ray.huang@amd.com, alexander.deucher@amd.com,
 Evan.Quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to add one sysfs file -- "pp_od_clk_voltage" for
Raven/Raven2/Picasso APU, which is only used by dGPU like VEGA10.
This sysfs file supports the feature to modify gfx engine clock(Mhz units), it can
be used to configure the min value and the max value for gfx clock limited in the
safe range.

Command guide:
echo "s level clock" > pp_od_clk_voltage
	s - adjust teh sclk level
	level - 0 or 1, "0" represents the min value, "1" represents the max value
	clock - the clock value(Mhz units), like 400, 800 or 1200, the value must be within the
                OD_RANGE limits.
Example:
$ cat pp_od_clk_voltage
OD_SCLK:
0:        200Mhz
1:       1400Mhz
OD_RANGE:
SCLK:     200MHz       1400MHz

$ echo "s 0 600" > pp_od_clk_voltage
$ echo "s 1 1000" > pp_od_clk_voltage
$ cat pp_od_clk_voltage
OD_SCLK:
0:        600Mhz
1:       1000Mhz
OD_RANGE:
SCLK:     200MHz       1400MHz

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 12 +++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/inc/hwmgr.h            |  5 ++
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 17 +++-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 79 +++++++++++++++++++
 6 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 0aec28fda058..94132c70d7af 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -281,6 +281,7 @@ struct amd_pm_funcs {
 	int (*get_power_limit)(void *handle, uint32_t *limit, bool default_limit);
 	int (*get_power_profile_mode)(void *handle, char *buf);
 	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
+	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size);
 	int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input, uint32_t size);
 	int (*set_mp1_state)(void *handle, enum pp_mp1_state mp1_state);
 	int (*smu_i2c_bus_access)(void *handle, bool acquire);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index b5d2f30043ad..fe0de00f56e2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -827,6 +827,18 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			return -EINVAL;
 		}
 	} else {
+
+		if (adev->powerplay.pp_funcs->set_fine_grain_clk_vol) {
+			ret = amdgpu_dpm_set_fine_grain_clk_vol(adev, type,
+								parameter,
+								parameter_size);
+			if (ret) {
+				pm_runtime_mark_last_busy(ddev->dev);
+				pm_runtime_put_autosuspend(ddev->dev);
+				return -EINVAL;
+			}
+		}
+
 		if (adev->powerplay.pp_funcs->odn_edit_dpm_table) {
 			ret = amdgpu_dpm_odn_edit_dpm_table(adev, type,
 						parameter, parameter_size);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index dff4a5f99bb0..f6e0e7d8a007 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -349,6 +349,10 @@ enum amdgpu_pcie_gen {
 		((adev)->powerplay.pp_funcs->set_power_profile_mode(\
 			(adev)->powerplay.pp_handle, parameter, size))
 
+#define amdgpu_dpm_set_fine_grain_clk_vol(adev, type, parameter, size) \
+		((adev)->powerplay.pp_funcs->set_fine_grain_clk_vol(\
+			(adev)->powerplay.pp_handle, type, parameter, size))
+
 #define amdgpu_dpm_odn_edit_dpm_table(adev, type, parameter, size) \
 		((adev)->powerplay.pp_funcs->odn_edit_dpm_table(\
 			(adev)->powerplay.pp_handle, type, parameter, size))
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 1b3529efc91e..3898a95ec28b 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -340,6 +340,9 @@ struct pp_hwmgr_func {
 	int (*odn_edit_dpm_table)(struct pp_hwmgr *hwmgr,
 					enum PP_OD_DPM_TABLE_COMMAND type,
 					long *input, uint32_t size);
+	int (*set_fine_grain_clk_vol)(struct pp_hwmgr *hwmgr,
+				      enum PP_OD_DPM_TABLE_COMMAND type,
+				      long *input, uint32_t size);
 	int (*set_power_limit)(struct pp_hwmgr *hwmgr, uint32_t n);
 	int (*powergate_mmhub)(struct pp_hwmgr *hwmgr);
 	int (*smus_notify_pwe)(struct pp_hwmgr *hwmgr);
@@ -347,6 +350,8 @@ struct pp_hwmgr_func {
 	int (*enable_mgpu_fan_boost)(struct pp_hwmgr *hwmgr);
 	int (*set_hard_min_dcefclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*set_hard_min_fclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
+	int (*set_hard_min_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
+	int (*set_soft_max_gfxclk_by_freq)(struct pp_hwmgr *hwmgr, uint32_t clock);
 	int (*get_asic_baco_capability)(struct pp_hwmgr *hwmgr, bool *cap);
 	int (*get_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE *state);
 	int (*set_asic_baco_state)(struct pp_hwmgr *hwmgr, enum BACO_STATE state);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index a6321f2063c1..bb8d077d3f05 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -911,6 +911,20 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
 	return ret;
 }
 
+static int pp_set_fine_grain_clk_vol(void *handle, uint32_t type, long *input, uint32_t size)
+{
+	struct pp_hwmgr *hwmgr = handle;
+
+	if (!hwmgr || !hwmgr->pm_en)
+		return -EINVAL;
+
+	if (hwmgr->hwmgr_func->set_fine_grain_clk_vol == NULL) {
+		return 0;
+	}
+
+	return hwmgr->hwmgr_func->set_fine_grain_clk_vol(hwmgr, type, input, size);
+}
+
 static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *input, uint32_t size)
 {
 	struct pp_hwmgr *hwmgr = handle;
@@ -920,7 +934,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint32_t type, long *input, uint3
 
 	if (hwmgr->hwmgr_func->odn_edit_dpm_table == NULL) {
 		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return -EINVAL;
+		return 0;
 	}
 
 	return hwmgr->hwmgr_func->odn_edit_dpm_table(hwmgr, type, input, size);
@@ -1645,6 +1659,7 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.set_powergating_by_smu = pp_set_powergating_by_smu,
 	.get_power_profile_mode = pp_get_power_profile_mode,
 	.set_power_profile_mode = pp_set_power_profile_mode,
+	.set_fine_grain_clk_vol = pp_set_fine_grain_clk_vol,
 	.odn_edit_dpm_table = pp_odn_edit_dpm_table,
 	.set_mp1_state = pp_dpm_set_mp1_state,
 	.set_power_limit = pp_set_power_limit,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 9ee8cf8267c8..791db107d51a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -242,6 +242,34 @@ static int smu10_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t cloc
 	return 0;
 }
 
+static int smu10_set_hard_min_gfxclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t clock)
+{
+	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
+
+	if (clock && smu10_data->gfx_actual_soft_min_freq != clock) {
+		smu10_data->gfx_actual_soft_min_freq = clock;
+		smum_send_msg_to_smc_with_parameter(hwmgr,
+					PPSMC_MSG_SetHardMinGfxClk,
+					smu10_data->gfx_actual_soft_min_freq,
+					NULL);
+	}
+	return 0;
+}
+
+static int smu10_set_soft_max_gfxclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t clock)
+{
+	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
+
+	if (clock && smu10_data->gfx_max_freq_limit != (clock * 100))  {
+		smu10_data->gfx_max_freq_limit = clock * 100;
+		smum_send_msg_to_smc_with_parameter(hwmgr,
+					PPSMC_MSG_SetSoftMaxGfxClk,
+					clock,
+					NULL);
+	}
+	return 0;
+}
+
 static int smu10_set_active_display_count(struct pp_hwmgr *hwmgr, uint32_t count)
 {
 	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)(hwmgr->backend);
@@ -527,6 +555,8 @@ static int smu10_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 	hwmgr->pstate_sclk = SMU10_UMD_PSTATE_GFXCLK * 100;
 	hwmgr->pstate_mclk = SMU10_UMD_PSTATE_FCLK * 100;
 
+	hwmgr->od_enabled = 1; /*enable the pp_od_clk_voltage sysfs file*/
+
 	return result;
 }
 
@@ -947,6 +977,26 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
 					((mclk_table->entries[i].clk / 100)
 					 == now) ? "*" : "");
 		break;
+	case OD_SCLK:
+		if (hwmgr->od_enabled) {
+			size = sprintf(buf, "%s:\n", "OD_SCLK");
+
+			size += sprintf(buf + size, "0: %10uMhz\n",
+			(data->gfx_actual_soft_min_freq > 0) ? data->gfx_actual_soft_min_freq : data->gfx_min_freq_limit/100);
+			size += sprintf(buf + size, "1: %10uMhz\n", data->gfx_max_freq_limit/100);
+		}
+		break;
+	case OD_RANGE:
+		if (hwmgr->od_enabled) {
+			uint32_t min_freq, max_freq = 0;
+			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMinGfxclkFrequency, &min_freq);
+			smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency, &max_freq);
+
+			size = sprintf(buf, "%s:\n", "OD_RANGE");
+			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
+				min_freq, max_freq);
+		}
+		break;
 	default:
 		break;
 	}
@@ -1348,6 +1398,32 @@ static int smu10_asic_reset(struct pp_hwmgr *hwmgr, enum SMU_ASIC_RESET_MODE mod
 						   NULL);
 }
 
+static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
+					enum PP_OD_DPM_TABLE_COMMAND type,
+					long *input, uint32_t size)
+{
+	if (!hwmgr->od_enabled) {
+		pr_err("Fine grain not support\n");
+		return -EINVAL;
+	}
+
+	if (size != 2) {
+		pr_err("Input parameter number not correct\n");
+		return -EINVAL;
+	}
+
+	if (type == PP_OD_EDIT_SCLK_VDDC_TABLE) {
+		if (input[0] == 0)
+			smu10_set_hard_min_gfxclk_by_freq(hwmgr, input[1]);
+		else if (input[0] == 1)
+			smu10_set_soft_max_gfxclk_by_freq(hwmgr, input[1]);
+		else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.backend_init = smu10_hwmgr_backend_init,
 	.backend_fini = smu10_hwmgr_backend_fini,
@@ -1388,9 +1464,12 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.powergate_sdma = smu10_powergate_sdma,
 	.set_hard_min_dcefclk_by_freq = smu10_set_hard_min_dcefclk_by_freq,
 	.set_hard_min_fclk_by_freq = smu10_set_hard_min_fclk_by_freq,
+	.set_hard_min_gfxclk_by_freq = smu10_set_hard_min_gfxclk_by_freq,
+	.set_soft_max_gfxclk_by_freq = smu10_set_soft_max_gfxclk_by_freq,
 	.get_power_profile_mode = smu10_get_power_profile_mode,
 	.set_power_profile_mode = smu10_set_power_profile_mode,
 	.asic_reset = smu10_asic_reset,
+	.set_fine_grain_clk_vol = smu10_set_fine_grain_clk_vol,
 };
 
 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
