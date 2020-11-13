Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431F0C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF69B20857
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 06:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lg3LaRYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF69B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D7A66E3EC;
	Fri, 13 Nov 2020 06:53:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72DFE6E3EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 06:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbNV6RjCf8ueWJcomPVBByFHDiZwNjOl/STTBburPCH/1t5ZijAAaXFpQgmGRsRF4c2ECLCQEuO3j65f7/hzoPh2izyFAd0SClX/2o0JSlXxDIkg2GLhoDCFNOfwgo4YhXdAKHrvLHrFOpET9L3FzfmqFTNmGikfABpvebaguJNgtugnsGjE7dW25XaP9+Q66goZ6zMzgT6+n02sMr5wF05jJeZp1r+Rz9KQXKqomNJaN15Rdf3NinmXHFhjrTqlBFIZaTXm6pUX4AN8vZDz85R56zd+IWjmxwedQBUFQNEEiUZOxhdLpRE+94E/YOcPug0cjU2sS9OWoxy6+omCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/aU7eg13waqbZfAiivau1glR70Gw3V393Gu83NgK1I=;
 b=P7O7UhBu0thAnvuOHqf09iITwzpLWli1PWLGCXIIjGsNy2CaquwoZyEITzCoPOpgiMoV27Vsek+hPJ4pKYOy3uByuqcBmEs+N5A1uLvN9354soW8XZhQPwJoNWUoCAQ+BdOAUGweDMUN9YpxjnlBN7/qmMeAgR0xUY6Lg9hS9YeQDE0kTHZpUfDwhV1rxWm/it+0VS+uUZlDmffGH5VzxNoOj7MOyXFh/h9OS1TgpEMmwd4lNbJUygC5Q0uReM3NFZgB7WagBrEl3Aq7KkFUgGiqW+TKKXsIV57xN8UVqiEs+kOqD/HjNdUDTI4Pnvyx8Z5WlonrSeckF8BPkwpYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/aU7eg13waqbZfAiivau1glR70Gw3V393Gu83NgK1I=;
 b=Lg3LaRYUcHgmiV2JysiHqlGta/JOyFypA2hYeV32nkfe8ZPjlkEy1W+rq6tLBpAa5cRrzfo8gX73/eoWlaMhkOI3cNmSPkMUqwDL6gwj+bei2JUhyK18vsO1l9xQf1kqgWExAQnIE26aqD3jvzOHCMCvei9EIHVEKdDuxWmaMTc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 06:53:31 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 06:53:31 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: add amdgpu_gfx_state_change_set() set gfx
 power change entry
Date: Fri, 13 Nov 2020 14:53:15 +0800
Message-Id: <1605250397-15043-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
References: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 06:53:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70fb2c88-e897-4907-02c5-08d887a0d51c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33333CA574737E9F122C3B83FBE60@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6tHXZyunfTUJ5jPcfBaJt2CcrlbBQLpP18YT+sc1BX22zbFIBbWsPqNyiAIWtcV1lsGzeQYs0WUierWQV1diTRI/0HkVcwcQy2nLnE0FJ7fbPdMUvg2OgDy1hR0Af2864khdXyR7kJPfkQT1XEK8TWiQyzvECtKUknLx5RZi3MR+IPpCWM1RSY34zxY/FgUblr42ZfnjscuGhPXaxseEipTNDCzZEGSt/KbrJk0i1Vn/y/etW+v79ctQQfVYQnqA++6ZwUvHT9EUaLFrDNQ8DkAMYzLiIiCq+C+1I2+8ncAX7MEfB/xMc2IwSw8jpamfYjIfPmTdg92PQiJf8BZ/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(2906002)(8936002)(66476007)(956004)(36756003)(186003)(478600001)(2616005)(86362001)(83380400001)(5660300002)(6916009)(66556008)(6666004)(4326008)(66946007)(8676002)(26005)(16526019)(7696005)(19627235002)(52116002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BiiTSsMV98kFY4wAdUYjQN1vTOWRDwaXLJegVDoX+ORL3u+Cu6VABsGO+XYUFry4WWeayAtY71D1vhwvlbwift7vApUfSgpvYOASQ/P3AZ/WpKK5apCaipm3mij2ZYco3HCTvMOIDdoOc3mVMW4NFJwNJ5//nk/ca4NdxAagr2gZfRVU6o4dG0HsDUCy18tIBdv0yuJHDRn1UZ5y/pKgfMKYMuE8TdZLkoGTukpPTdj7qLlcQegcmGqufshYv5dyMhSfnJUMPoIgIOfESE5JAZVZ38ywIwkX5/DnOuZJn500I2AobVsU9yZDjzc7kukW/7sRfE5r1tNNc74vC7MHYQtmlb6+JlVVlmtd8kyuYiuOxwPKHTW9yLY9/yvteX+PS+zqAd9PT7mXUS/QR27PplGWgafTi+8yY7NMqu+qaeOeqYNaijf/QuS1ygA7g1DedzClxBd7ajOrE1i7VggRWmub8Gp3RbZyXsQ3HXBR/FYYMuUu8pMB6GVOCee8bUdDTfQYZPIT3i6VXPqqSWTxoeuPAKZ5VLpgK44Yc6Js16lVeG2PicTWlj/9lf1ae60lKlaEWll2cIOPrxCmRuKoSSpqEgWuwJdDjV26tbcGR/GzG22Wrln1mEgCwJrt083lGiBr6b1mCbcAfVW/5+gOYSEsmx/5gbwOq4Z2cwVyAKjsd0ly58coOJBKTkeXzu9wsmkHR/rpYm2SXl1uYyhWjX8DcyiEEdKIE4Wl0FiIxCXrZRBQsQ1CILjOKgBe/RU10ai3zlg0W0nqVMR1yjh2RQmQi++Jcu2OXgDbYXH9mnpOOp7ZF2S/QiEyxoe8pL5MWdB2ks9qkvFqyrDEW1fEUJ1fE27zO/fqZ/D9Xhcy07yt4oKueuzwWPASl1PEegBKuVib3IMGFPk93MR2pywNZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fb2c88-e897-4907-02c5-08d887a0d51c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 06:53:31.4624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIm15cwlcASlKHP0bCFLpovXo9Nvme8rUGxILd7GCaNrZ/Y690tcp5pDsxivzAb2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The new amdgpu_gfx_state_change_set() funtion can support set GFX power
change status to D0/D3.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c              | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h              |  7 +++++++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h       |  1 +
 drivers/gpu/drm/amd/pm/inc/hwmgr.h                   |  1 +
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h                |  3 ++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c     | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c |  9 +++++++++
 7 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 97a8f78..380dd3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -819,3 +819,23 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 	}
 	return amdgpu_num_kcq;
 }
+
+/* amdgpu_gfx_state_change_set - Handle gfx power state change set
+ * @adev: amdgpu_device pointer
+ * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
+ *
+ */
+
+void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
+{
+
+	mutex_lock(&adev->pm.mutex);
+
+	if (adev->powerplay.pp_funcs &&
+	    adev->powerplay.pp_funcs->gfx_state_change_set)
+			((adev)->powerplay.pp_funcs->gfx_state_change_set(
+					(adev)->powerplay.pp_handle, state));
+
+	mutex_unlock(&adev->pm.mutex);
+
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 671d4b3..6b5a8f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -47,6 +47,12 @@ enum gfx_pipe_priority {
 	AMDGPU_GFX_PIPE_PRIO_MAX
 };
 
+/* Argument for PPSMC_MSG_GpuChangeState */
+enum gfx_change_state {
+	sGpuChangeState_D0Entry = 1,
+	sGpuChangeState_D3Entry,
+};
+
 #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
 #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
 
@@ -394,4 +400,5 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
+void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state);
 #endif
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 94132c7..f775aac 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -285,6 +285,7 @@ struct amd_pm_funcs {
 	int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *input, uint32_t size);
 	int (*set_mp1_state)(void *handle, enum pp_mp1_state mp1_state);
 	int (*smu_i2c_bus_access)(void *handle, bool acquire);
+	int (*gfx_state_change_set)(void *handle, uint32_t state);
 /* export to DC */
 	u32 (*get_sclk)(void *handle, bool low);
 	u32 (*get_mclk)(void *handle, bool low);
diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
index 7e29ec2..1bb3794 100644
--- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
@@ -366,6 +366,7 @@ struct pp_hwmgr_func {
 	int (*disable_power_features_for_compute_performance)(struct pp_hwmgr *hwmgr,
 					bool disable);
 	ssize_t (*get_gpu_metrics)(struct pp_hwmgr *hwmgr, void **table);
+	int (*gfx_state_change)(struct pp_hwmgr *hwmgr, uint32_t state);
 };
 
 struct pp_table_func {
diff --git a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
index df4677d..4c7e08b 100644
--- a/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h
@@ -83,7 +83,8 @@
 #define PPSMC_MSG_SetSoftMaxVcn                 0x34
 #define PPSMC_MSG_PowerGateMmHub                0x35
 #define PPSMC_MSG_SetRccPfcPmeRestoreRegister   0x36
-#define PPSMC_Message_Count                     0x37
+#define PPSMC_MSG_GpuChangeState                0x37
+#define PPSMC_Message_Count                     0x42
 
 typedef uint16_t PPSMC_Result;
 typedef int      PPSMC_Msg;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index eab9768..e0d2882 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1629,6 +1629,24 @@ static ssize_t pp_get_gpu_metrics(void *handle, void **table)
 	return size;
 }
 
+static int pp_gfx_state_change_set(void *handle, uint32_t state)
+{
+	struct pp_hwmgr *hwmgr = handle;
+
+	if (!hwmgr || !hwmgr->pm_en)
+		return -EINVAL;
+
+	if (hwmgr->hwmgr_func->gfx_state_change == NULL) {
+		pr_info_ratelimited("%s was not implemented.\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&hwmgr->smu_lock);
+	hwmgr->hwmgr_func->gfx_state_change(hwmgr, state);
+	mutex_unlock(&hwmgr->smu_lock);
+	return 0;
+}
+
 static const struct amd_pm_funcs pp_dpm_funcs = {
 	.load_firmware = pp_dpm_load_fw,
 	.wait_for_fw_loading_complete = pp_dpm_fw_loading_complete,
@@ -1691,4 +1709,5 @@ static const struct amd_pm_funcs pp_dpm_funcs = {
 	.set_df_cstate = pp_set_df_cstate,
 	.set_xgmi_pstate = pp_set_xgmi_pstate,
 	.get_gpu_metrics = pp_get_gpu_metrics,
+	.gfx_state_change_set = pp_gfx_state_change_set,
 };
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 133a084..3089fba 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1439,6 +1439,14 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
+{
+
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GpuChangeState, state, NULL);
+
+	return 0;
+}
+
 static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.backend_init = smu10_hwmgr_backend_init,
 	.backend_fini = smu10_hwmgr_backend_fini,
@@ -1485,6 +1493,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.set_power_profile_mode = smu10_set_power_profile_mode,
 	.asic_reset = smu10_asic_reset,
 	.set_fine_grain_clk_vol = smu10_set_fine_grain_clk_vol,
+	.gfx_state_change = smu10_gfx_state_change,
 };
 
 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
