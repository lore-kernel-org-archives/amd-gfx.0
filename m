Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E0BC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4572520748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UOM0TrHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4572520748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A446EC60;
	Fri, 10 Jul 2020 14:17:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7496EC5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 14:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfknuXioYE9lQ8nVnHxaQhfwPnYpfWFHWX2/9/FKZjGhwV5rC6uEzXgNMsWJ4tEhcJHHYS0KtvckDg5CV+KPT84zkXiR7eX8gIrW4WJxGP91oXd5XqzS3QwESJzoUFLLnPr76JY/HycIhXehlwSctWA7YzyewuF1uu6XVO2JlKQNOfT+o4cinHNFu3NKs+amxNb/ay4Kad9jqQ51oIlNQqa/DTSgkGKLuPUUpMJgZ1hOcAulynGzrz0YNXy5L/kcGJI6ErxjTWaVdFljaz4xTCeJbKjw0oHC9taf2JhnYT6dAJ18CfkTdCXcH/GhwGsSRoYgjsU1OHX0+xdLHH30zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLDtnwslzO6yr6uUClw22pzV3us1rTO4/s6W4ttnOI=;
 b=nP3npHjUYeWPIP9WurjsZ/sr/A5G4mYzxxXwUtB08a6/05DzzaibaXwXrVe4SkN/uiJC+ZNUkOT/HX3Je3UecqhYQXJNqTfIxzgVO9KNn8R6WVX3ysWVOeihdoIdoA+z1P7SNrWMh93dfGbr3CQ1P3K8OMvXdjGCNKjTTiKzXX6TOEbgXQTzARPpIpiDVmKNKs+SVHFll/J5wf5ediI00PACzN/Qp8CHeHi9KqCpcP4YFTQLy0+DmKcZ3qfAI1j2Nd+Q/M3lgd7LqbA1WkTMP4fHbbmFir2f79BJMrJbwBPHXx3ppaA649KBkntXGdAX/BRwFsfGJNr/hWQlsQLAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGLDtnwslzO6yr6uUClw22pzV3us1rTO4/s6W4ttnOI=;
 b=UOM0TrHLBTUc9xGaasrhROuiAZOlXD6glGk5PH3NMuFVJofKVXNtuh8MN4StyqUeCNh342lhGk7feAjO00hYTtV21rzVcTlH5DPYliqTB6hAnGSgVkOL1YuZOCT/JnRCOYhp1KYP7+auwVeKmqBVU0ORcrUiA5t9bJiNo3zU1Tw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3976.namprd12.prod.outlook.com (2603:10b6:610:28::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 14:17:02 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 14:17:02 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: enable mode1 reset
Date: Fri, 10 Jul 2020 22:16:43 +0800
Message-Id: <20200710141644.1601-2-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
References: <20200710141644.1601-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK2PR04CA0063.apcprd04.prod.outlook.com (2603:1096:202:14::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 14:17:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e315b7e-9b79-4275-5d5c-08d824dbea81
X-MS-TrafficTypeDiagnostic: CH2PR12MB3976:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39764FAB86AD607190CF5B0B8C650@CH2PR12MB3976.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /B7fe2aZciZRNY8BENwM5Oh/VipTEGskK4WPhrn/WSpAvXwfJ9sLCZx1qokZxnBDqjH/FFnDMR7PZQWlEk2JA/3xYCzHULQvo384fp8cUQdPEcc6hek7PQ/njtVSMoNmjh64JfuDVOZxwvC7aPWlZ1K3BknF8ZdhTm7VT3cNwNty2z3nly/uzt06dL7wiHs5S+MgLbLJpinta88IWmnKUexdt06gMYfPJX4HVuBduWLg7c89Mc2uhQ7JSuV+E4g8u96VbHUMnXXcPp/XCal08x0PdVzJA2a+MT5ezTFJyUB2sqxlk00zLvjSRpBNoKkBzTa4Ra8VoqIkiMvlfB1KxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(16526019)(956004)(478600001)(316002)(54906003)(2616005)(86362001)(8936002)(4326008)(8676002)(2906002)(26005)(1076003)(83380400001)(5660300002)(66476007)(66946007)(6486002)(66556008)(52116002)(7696005)(6916009)(186003)(36756003)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bK03HoktagHGuJBBU1GOTSr5gRN4U1euYk8WVSPYsoKXCXlhgOxae0GhOfFx0Bzs4NRxGHDyM7TqSvvRKeCHp0YMoJ13f8V5GE+SW38/AnhcmssjTFfHQ4jTDSQTwCdKm/WheokpOtNSV+bPczM9K7QQClkFnb3GC8lNSo4KyXP3/cWFyuZWkB7NxWra6Fp9oTiSdMV1NWwy/9hTR5/xTjXAjzGkqeIoSxJDe8QjAPuWtI+ONJxKlm7ZygBtJWAW2NBi1QfP7lO2SSId5YU1cy9Ce1KLRPRQQaJ9/oVrNGoHt/rVPypEX5jIiySjZf946WpLZ0Kfn+79F3effrj45Fsf0zUQ3zZ+R/T7O8hRXLkc7wKgzyPsCzeGWmcnSdmaV8zvhxVwle2gGp4KN0j+mvcmTCT/dkRfNfw1bNl6HjfnauG5FSiuiUottMnMOpBW+MLAdgmCMmkLLqOhmbJIoyyeLtccuCa2naKdOECpykj2NFin0rZmqKGQXpag/2z1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e315b7e-9b79-4275-5d5c-08d824dbea81
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 14:17:02.5641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8C5xtMKQfz1gmEcpN62QNp4uLBUDjIpjoWGXvjLBvZEGiJvIZkqyY25iOJdLOtE7wijOyKtkOAmKI2ENq1UWOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3976
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
Cc: Likun Gao <Likun.Gao@amd.com>, Wenhui Sheng <Wenhui.Sheng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For sienna cichlid, add mode1 reset path for sGPU.
And fix some corner cases about mode1 mode reuse.

v2: hiding MP0/MP1 mode1 reset under AMD_RESET_METHOD_MODE1

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/nv.c            | 19 +++++++++++-------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c |  2 +-
 5 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fec6cf3f0c8a..6ce6e6bb8b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4274,18 +4274,19 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_hive_info *hive = NULL;
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
-	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
+	bool need_emergency_restart = false;
 	bool audio_suspended = false;
 
+	/**
+	 * Special case: RAS triggered and full reset isn't supported
+	 */
+	need_emergency_restart = amdgpu_ras_need_emergency_restart(adev);
+
 	/*
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (in_ras_intr && !use_baco && amdgpu_ras_get_context(adev)->reboot) {
-
+	if (need_emergency_restart && amdgpu_ras_get_context(adev)->reboot) {
 		DRM_WARN("Emergency reboot.");
 
 		ksys_sync_helper();
@@ -4293,7 +4294,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	dev_info(adev->dev, "GPU %s begin!\n",
-		(in_ras_intr && !use_baco) ? "jobs stop":"reset");
+		need_emergency_restart ? "jobs stop":"reset");
 
 	/*
 	 * Here we trylock to avoid chain of resets executing from
@@ -4365,7 +4366,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_fbdev_set_suspend(tmp_adev, 1);
 
 		/* disable ras on ALL IPs */
-		if (!(in_ras_intr && !use_baco) &&
+		if (!need_emergency_restart &&
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
@@ -4377,12 +4378,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
 
-			if (in_ras_intr && !use_baco)
+			if (need_emergency_restart)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
 		}
 	}
 
-	if (in_ras_intr && !use_baco)
+	if (need_emergency_restart)
 		goto skip_sched_resume;
 
 	/*
@@ -4459,7 +4460,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		/*unlock kfd: SRIOV would do it separately */
-		if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
+		if (!need_emergency_restart && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3a3fa8567c94..6f06e1214622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2135,3 +2135,14 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 		amdgpu_ras_reset_gpu(adev);
 	}
 }
+
+bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
+{
+	if (adev->asic_type == CHIP_VEGA20 &&
+	    adev->pm.fw_version <= 0x283400) {
+		return !(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) &&
+				amdgpu_ras_intr_triggered();
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e7df5d8429f8..b2667342cf67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -633,4 +633,5 @@ void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev);
 
 void amdgpu_ras_set_error_query_ready(struct amdgpu_device *adev, bool ready);
 
+bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 356849136d1d..9f1240bd0310 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -265,17 +265,21 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
-
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
 	pci_save_state(adev->pdev);
 
-	ret = psp_gpu_reset(adev);
+	if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
+		dev_info(adev->dev, "GPU smu mode1 reset\n");
+		ret = amdgpu_dpm_mode1_reset(adev);
+	} else {
+		dev_info(adev->dev, "GPU psp mode1 reset\n");
+		ret = psp_gpu_reset(adev);
+	}
+
 	if (ret)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
-
 	pci_restore_state(adev->pdev);
 
 	/* wait for asic to come out of reset */
@@ -307,7 +311,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
 
-	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
+	if (smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
 		return AMD_RESET_METHOD_MODE1;
@@ -319,15 +323,16 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 
 	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+		dev_info(adev->dev, "GPU BACO reset\n");
+
 		ret = smu_baco_enter(smu);
 		if (ret)
 			return ret;
 		ret = smu_baco_exit(smu);
 		if (ret)
 			return ret;
-	} else {
+	} else
 		ret = nv_asic_mode1_reset(adev);
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 4f7d064e16e4..014815bcae93 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2039,7 +2039,7 @@ static bool navi10_is_baco_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t val;
 
-	if (!smu_v11_0_baco_is_support(smu))
+	if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu)))
 		return false;
 
 	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
