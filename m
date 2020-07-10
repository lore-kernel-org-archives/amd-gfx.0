Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE58C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8282072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 05:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G3RiLKmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8282072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3406EB6D;
	Fri, 10 Jul 2020 05:46:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B346EB6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 05:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P73lUATvhEXWoPRl/RBQzaanZkn6ts0iuNKjyRyjLmvzvX+CqcAwd+AFpOPYtQVpEOzw7PHKmHPWAxCCXEZYSPP/dQjaakDAy2KNzhqTbvSi+cTiVDQPunqJNGl9KYROdjLxowz2yrXkkPyS5SmsugwMsB2kHkMA+WmhBsUkXSiJYcxj/hhxL/2KY+MvFpr3v2qoDRHNACOeIz9OPb2o24X+7LdZyiB2t09DZYxxVpsa3EnaOZYiBqYd3pRkKN40GZjR/AhzGsu8rkHcuVA0153wQQDngtS87SflBJ/7eFxyjIVZIW5NdJcKsigu1NQVquUJ4TFW0T5MBEiAVfDoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLkq8PkFEolGc9JJ/vUSsV28TOg9Rq4UGdTlI6I+MFs=;
 b=K2eF5jzi7eHSGG7yIpiKWy5TLGX7QmwAlpw3dTqaN1ZM/4Sy+yat2OJQZIU4ViyawOge9Po5YqElFsDbqgwyzQxw+Az124N7g58maJ1wNMFTKRAiVBMlEIsKnYuj5ArBqOeyMqUSxVqoeHIKJa45kXUpOtPmARQhVoxdCZLWUhDPlakPRYXlq7F3/TjVhmy3ERBocOoDW1GLSrHo3q/TJuSjfKfvjUYqdqP/tU67Rvwt3Js/WeIQ0VOLGQSQ9a9DaDeZIf0OJQ2mVS/DwZ+fwT40znSD9KhDzW050aEIUzo7B7sBZgPHBGpkDanTtcTrdfZ1bcwayA3rKRqvUDHqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLkq8PkFEolGc9JJ/vUSsV28TOg9Rq4UGdTlI6I+MFs=;
 b=G3RiLKmFa75Bo7Z9utvo8uzsr/pXHplPjFcWfgM/piw++AG0t8YxG1N3ikctK9+ZtnY/4fBf1o/w8GfZWyWZt1i0pYki0skpZEClTO4qBhDlZCuFnzKY597tMkD0xVCnC+FM8+BCbKrWqhYV71ug1tDiCQQKIfXh+kdWrO6xUn0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:46:43 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 05:46:43 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: enable mode1 reset
Date: Fri, 10 Jul 2020 13:46:25 +0800
Message-Id: <20200710054626.2487-3-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.242) by
 HK0PR01CA0056.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Fri, 10 Jul 2020 05:46:41 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc69b0b5-bc1b-4528-c4c4-08d82494a01a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4055D496D9D008ACCBF3C3538C650@CH2PR12MB4055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOaTAJznUNfELhzmg93uwlXRs+EUoA5ZP3j0QSul533QafdvGKvw6pimqDnFcLn2fhCe5hrVl9f3C5a5sBvGsBWZSHRqyftM1whkriuuLn7wyaB7SCKs66CftgLIEOON9Yx2pvukxRxZdBq2NgE9j2VzSDL5XXdw+CeHcqiaWnOI7ZrT0wO9njTMbLPSzl+EQ6VQxKwll6fxiXIROpRxRTbjUNxBE3rw1SXc624ErRtxaZt6oIwyoD431OA0YXjpwI5QTp9uWXsR6VjfdXxpUklP5BS4+M7bZiu32C5v1foliVbfyGxcsbkH1g/jxGmX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(83380400001)(2906002)(6916009)(8936002)(6486002)(8676002)(1076003)(186003)(16526019)(6666004)(956004)(26005)(86362001)(2616005)(36756003)(4326008)(66556008)(66946007)(316002)(54906003)(52116002)(7696005)(5660300002)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: E0FrsxB+FPbUYj6DAib7no5eRI27HZn3rl4mQ5fWlnw2vC87hIlgbfftnfYk1wCe9A1MX0CJxeuXfDgd51wsQnuCHnEwJJTzofW0qyHs3tFcW2hNVY7Yi2dYEAUfFffl4sr4d0rOR26EPldUIh9HVaNDm0e6IP7gkNtGczRfD9SVlJOQJLLKkG4r+lgus3MwI+nH2qb7yW84JpDg/kdQAlK1mQJrOJspLm8wMWTNrWNpIRb5oIfnKkoGKxFE00K2MxdJd63wsNK2KpmW1ly5h2J12kY3gBt/OE66u6V0whSorcQV4ue26eIc+ARARMqkMxBtZIKH+6EsIDHE02IrUgw/0rp56IWeJMv8E8tWoArOHQyTKO6nRgaXrXBEsJXP+vUeMDE7MJxGAegfoPLsrgnsG5IYJvg58ReCyuAqVufgSr/CXx/b5G2btlbZtVnCBbuaB5fFjSXjZpV8IjdV3CQcTTeFkx4LpGeUbAXyHpsn76U5zsUhQVLe40Ooj7Rv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc69b0b5-bc1b-4528-c4c4-08d82494a01a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 05:46:43.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dSAFSGOsB5g6rYRLr6la+UuXXK4errteOdoeoOi6BrAFINFxPYRphBRe5KyvAKkEazT8fVYau/MLX8Pij/pwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 24 ++++++++------
 drivers/gpu/drm/amd/amdgpu/nv.c               | 32 +++++++++++++------
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  2 +-
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  2 +-
 4 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 565dc59a9e89..85d2aee546b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2119,6 +2119,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 	 */
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_BACO:
+	case AMD_RESET_METHOD_MODE1:
 	case AMD_RESET_METHOD_PSP_MODE1:
 		return true;
 	default:
@@ -4220,7 +4221,8 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 	 */
 	reset_method = amdgpu_asic_reset_method(adev);
 	if ((reset_method != AMD_RESET_METHOD_BACO) &&
-	     (reset_method != AMD_RESET_METHOD_PSP_MODE1))
+	    (reset_method != AMD_RESET_METHOD_PSP_MODE1) &&
+	    (reset_method != AMD_RESET_METHOD_MODE1))
 		return -EINVAL;
 
 	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
@@ -4275,16 +4277,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
+	bool is_full_reset = false;
 	bool audio_suspended = false;
 
+	if ((amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ||
+	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE1))
+		is_full_reset = true;
+
 	/*
 	 * Flush RAM to disk so that after reboot
 	 * the user can read log and see why the system rebooted.
 	 */
-	if (in_ras_intr && !use_baco && amdgpu_ras_get_context(adev)->reboot) {
+	if (in_ras_intr && !is_full_reset && amdgpu_ras_get_context(adev)->reboot) {
 
 		DRM_WARN("Emergency reboot.");
 
@@ -4293,7 +4297,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	dev_info(adev->dev, "GPU %s begin!\n",
-		(in_ras_intr && !use_baco) ? "jobs stop":"reset");
+		(in_ras_intr && !is_full_reset) ? "jobs stop":"reset");
 
 	/*
 	 * Here we trylock to avoid chain of resets executing from
@@ -4365,7 +4369,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_fbdev_set_suspend(tmp_adev, 1);
 
 		/* disable ras on ALL IPs */
-		if (!(in_ras_intr && !use_baco) &&
+		if (!(in_ras_intr && !is_full_reset) &&
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
@@ -4377,12 +4381,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
 
-			if (in_ras_intr && !use_baco)
+			if (in_ras_intr && !is_full_reset)
 				amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
 		}
 	}
 
-	if (in_ras_intr && !use_baco)
+	if (in_ras_intr && !is_full_reset)
 		goto skip_sched_resume;
 
 	/*
@@ -4459,7 +4463,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 skip_sched_resume:
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		/*unlock kfd: SRIOV would do it separately */
-		if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
+		if (!(in_ras_intr && !is_full_reset) && !amdgpu_sriov_vf(tmp_adev))
 	                amdgpu_amdkfd_post_reset(tmp_adev);
 		if (audio_suspended)
 			amdgpu_device_resume_display_audio(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 1d27dd3676ad..abccb155b28e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -258,23 +258,32 @@ static int nv_read_register(struct amdgpu_device *adev, u32 se_num,
 	return -EINVAL;
 }
 
-static int nv_asic_mode1_reset(struct amdgpu_device *adev)
+static int nv_asic_mode1_reset(struct amdgpu_device *adev,
+			    enum amd_reset_method reset_method)
 {
 	u32 i;
 	int ret = 0;
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU psp mode1 reset\n");
+	dev_info(adev->dev, "GPU %s reset\n",
+			 reset_method ==  AMD_RESET_METHOD_MODE1
+			 ? "mode1" : "psp mode1");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
 
 	pci_save_state(adev->pdev);
 
-	ret = psp_gpu_reset(adev);
+	if (reset_method == AMD_RESET_METHOD_MODE1)
+		ret = smu_mode1_reset(&adev->smu);
+	else
+		ret = psp_gpu_reset(adev);
+
 	if (ret)
-		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
+		dev_err(adev->dev, "GPU %s reset failed\n",
+				reset_method ==  AMD_RESET_METHOD_MODE1
+				? "mode1" : "psp mode1");
 
 	pci_restore_state(adev->pdev);
 
@@ -307,8 +316,10 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
 
-	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
+	if (smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
+	else if (smu_mode1_reset_is_support(smu))
+		return AMD_RESET_METHOD_MODE1;
 	else
 		return AMD_RESET_METHOD_PSP_MODE1;
 }
@@ -317,17 +328,20 @@ static int nv_asic_reset(struct amdgpu_device *adev)
 {
 	int ret = 0;
 	struct smu_context *smu = &adev->smu;
+	enum amd_reset_method reset_method;
+
+	reset_method = nv_asic_reset_method(adev);
+	if (reset_method == AMD_RESET_METHOD_BACO) {
+		dev_info(adev->dev, "GPU BACO reset\n");
 
-	if (nv_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
 		ret = smu_baco_enter(smu);
 		if (ret)
 			return ret;
 		ret = smu_baco_exit(smu);
 		if (ret)
 			return ret;
-	} else {
-		ret = nv_asic_mode1_reset(adev);
-	}
+	} else
+		ret = nv_asic_mode1_reset(adev, reset_method);
 
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
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 612788bbc6c3..319480550bb7 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1761,7 +1761,7 @@ static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
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
