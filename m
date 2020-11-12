Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EDCC56201
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9582100A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 07:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uycDaErI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9582100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB796E138;
	Thu, 12 Nov 2020 07:06:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352EE6E118
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 07:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKdEhUsVDKYO0Uxns2y5oSAMX+WABkUoEZPbnaDCGYtFmPdlauHNy9jEpP1aj24VSc73bOynR/RmAvAGplnrsk2qb/x7KYScNwLVhP4aRaGO6CZFMB36ALWHXIWhOWlQgj5GySKwPJb4q1TTyPuxhyN++MNmORrLiF8Dp62nufrPRW84P42ZQ3hL4yPRFdtLjriR5vM0t0teVcQ5UbIUk3cxgrWkLXIYKQ0VOXtUKYCC3wXpWi8Py2FN2DbmBhGhLxA6hlWjslN9+69o3avCsCu6iPxdIj3wiKU9Q0CtC5nzulry9jOAElXxHYX+Z0VO1oAvCC6vw3sodvqNCCPjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swL7Nkr6Piq1mdjukxHSTi6E7SDNukqbfaiooKUnIIk=;
 b=Vbv9bTSnm7YfVZXocEMZKLUkTxQxivJVmJBumbeRTtZgw/J6XhbhH84pAEMcFPL17yQ+fa0xjt39jK+Y41ez0IRtR5vR3brGa1ha0xmJ/IqBAayAqZyTPRGxlKfbMDlb8XGaGAfzRH7ri67xkyYPRo9rI/Vd/PoctnAhMJRlK3nBxQ7B6q2bwMD8RVLayCs1P7lfZNqqLbC2n8kqnsFqlE5qY1NRIxWVd3D8gcT/iDDkbJRwopYQbIbsmcp4/zGVfwsKAImRkvrTVt28+11V0RAIWYXQqrk+NqlA3Pki//cFpWWJo02Cvk0ZKAV5lkfGW2GZGxAac6yWRO6SRbL0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swL7Nkr6Piq1mdjukxHSTi6E7SDNukqbfaiooKUnIIk=;
 b=uycDaErIS5t1T0TBFPbTZu/5QcdaOvMm/PwGtj0IW7OyG23n5YvYiP34CFG6ELT4CEazlJA4/TIX4cgUYNxeHJ++j12e2Se8fHMHschspn0jfI5lXwcqiwUZO0zi3eBYI69rEa/ZxUCxNQniX83ugLC9qm1443nKErHwvfyqKOk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB4789.namprd12.prod.outlook.com (2603:10b6:a03:111::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 07:06:45 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9866:32dc:79cb:d695%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 07:06:45 +0000
From: Prike Liang <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: add amdgpu_gfx_state_change_set() set gfx
 power change entry
Date: Thu, 12 Nov 2020 15:06:33 +0800
Message-Id: <1605164796-22215-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
References: <1605164796-22215-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To BYAPR12MB3238.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 07:06:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36e2f69c-8fdf-40fc-5fcb-08d886d983f2
X-MS-TrafficTypeDiagnostic: BYAPR12MB4789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB47891AF41ADE313F4D4C5A0DFBE70@BYAPR12MB4789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UgCGMg7sn7LwTTd8XNyBFaRpmWdVy6w4LCHaP+hRYYGWU2ztEi/UGCgfBtu7GjIYtTDkEBF0dPxZ9fPPAvldgVJ2J7z7HYxwhc2go9dp8TRsAPjfdWe+8JVx8pBAmrJZA0oQWntpg93CXWazv4+XAAj7LHPfXgrDeXfGnVV8eWxelduS7ahTFg/6EQOEo3y7CE/3rmHvYNkvIaMXNGHExUz1gmRseUXo7UkgxQf6zMUMoGrZM6p8VHG4NK6H6yMrFl1euFlBQLivUVmU+niSLR60aT6AeBFgEmdi1RX3ZDGSzBx9PbIOHTcV5K8d4dK5XaRUQNgHNvlLJ5yOX8fHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(7696005)(478600001)(316002)(86362001)(6916009)(6486002)(66476007)(4326008)(66946007)(66556008)(5660300002)(52116002)(83380400001)(36756003)(2616005)(2906002)(6666004)(8676002)(16526019)(186003)(956004)(8936002)(26005)(19627235002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xluHd7Bgn9nTvy5FCCpilKDlAuZeb5XSTEZZFJ5/Z4v0xhdMIsSmy4Z4VxZLpCrgRaQRrUiLP6e5DhMpNEVcX0S3AHOVM90rTtX8vR/HItOhU5yq/p79O6z8qWmoY8+E9MWwWeAeZnr2+0S3wdC4Wi/3gMIILh3UpaT46ylRZmGwE4npGK/8J+QELa/pTO2Xskl5hFjRK99lJB/vKGW9+oOKhCs5cvq2fkZC7b24J/J8V+Tz3QV4YScNaQVBgvOtDdw44yjud5h+22sabu/VcKfQIescZFAzdhA2410sh0KPpcZ4fLEid08WDOLA9RFGrMkVmmSX5XfA6WW0RPhLpMA7PqOPI35Zdc5orDgN+9fKYgDPp8RBHO/9WpdRL8UWP5S2a8Y9K2uG1KgetRPhBHg1ZctWIVd0zzEqOinUBg7k3p16yW7Gw8FkshlS7I9XI+jl0qa16ByhHJOdiFVTIp31kxs8UWjZogbKQGyCCaQQc5zD7YxAQ26CnsoVXfDiewJioa+D9PeHwfg0icHIJUftnMuy6eR13aJWGtu99XvkSOBmmrnWFcRGwqvwENKzBbRDYkz03Y4HewTWBTkVBIf6aCjjFP353A//Jc8LfYCzYsCRVXcVfgNEKi8e080GU5tX+ZgzDEDxU8CwCs6WhBTco7BNDx7p/rb9ZaKi47zjR7j/Fs82f0o1npumf2IhS644XBAPm9Uae9ElBcEZisVWF6EeCfR6z798oD+b9uZb959fSY6xYFt+tCQTPf9BtbOrsEdDLLDKgvHvvH6LyD0yC2nrQ4k3fqZ7rIjD4OJZzTpeJk4036C89IXq453YeCW5/P2RBx+nf3kTynu2LtAtG9kzS200srk/qZSsU8xnRtSzE0In0kSQngbx7eL39PywiY/QlAtAx8ROVV9o/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e2f69c-8fdf-40fc-5fcb-08d886d983f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 07:06:45.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC7DKWhNRyQEsHLMBMq37rqCJcznhENzYPSiqrfzaXAGchNPIV1wdQYZsgG6NsNS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4789
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
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 10 ++++++++++
 7 files changed, 60 insertions(+), 1 deletion(-)

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
index 133a084..50308a5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1439,6 +1439,15 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static int smu10_gfx_state_change(struct pp_hwmgr *hwmgr, uint32_t state)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GpuChangeState, state, NULL);
+
+	return 0;
+}
+
 static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.backend_init = smu10_hwmgr_backend_init,
 	.backend_fini = smu10_hwmgr_backend_fini,
@@ -1485,6 +1494,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
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
