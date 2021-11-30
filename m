Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42625C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE3816EEB6;
	Tue, 30 Nov 2021 07:43:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF3B6EEAC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGvBrbwS/MRYtTT/IQ+uC7hCq9KbQ6MEFYJ5XktRmgTTyc3erYjigOgddQg49aWFVYcIMvVrm9XtGRNN2+KmY1CkiiULahyQz801Ck5i5BAwNhuoUTorCrZcANmDBJoQ+MFl+LbmrqixR6VHRYE+WmoudrqwQHyZJC1yEosnR/dHZ8b/NLZQoN2KLvadoxAR3szOzO7dsc7PzEvTVP3yRM8PEXBg6G5oApfYfBmRm54Wa8psiclnNklFgGR2zvjdKMH2JYxjpmtxGd+0ubGnqyATBMr+Pcat2vpxIDeRRKjzZqeCImV7mOYEYhysBHqnYx62H1WDEj84l/ihO42cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67OSeZ5s8Ts/onBCrqzmCNGlPQPVyUr98/c8FYOi4e4=;
 b=dQY4LXKWqUQdASlVYRn4Wzcfz8O6WiFNSdtzrxxTkLbBhwxaj6ThQqp+gfEXQNKKzVFqE0FRZZt73Yuiq5+rWDeZkzA1qnOXzzqJatwUAQTPTIksWtq79q44LSI4NzFU5tL+6NkxBkS1FNyx8ZMAgim/qdrpd5A4SVWK+hwQlFhGI1yIqDFM1fhj8+1JbwhNfXN4BB0qUdB+w6ktmCQiYU+VEcWXyOagPoTSXQrkRv8cgCth2Y2j3fjex1LQq13avcyOYP8xPqVefky2G546cWOr2AM+10oQIEUjbOTKUaUf7hJAVDe1jcY0Vzd0RF9ByQnt9eJ0c3XmuUOEBr5/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67OSeZ5s8Ts/onBCrqzmCNGlPQPVyUr98/c8FYOi4e4=;
 b=RusNFcocrBpOWPsX9L/SnZb70pnnS/jDYq2EiSDDo2cYT7ojnIQS2A0IV4UyNoRbX02yCYFYwm0MyvF6L/xNGVBW2vDjbxBbxuMwBI9ppGRy5AuhIUZtLRUT3Xojbaw06swCEeaPhUiPCU62ce3JN6Eb2kkqVjvlCWs0UA1XBKI=
Received: from BN6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:404:13e::31)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 07:43:25 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::4c) by BN6PR13CA0045.outlook.office365.com
 (2603:10b6:404:13e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:25 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:22 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 01/17] drm/amd/pm: do not expose implementation details to
 other blocks out of power
Date: Tue, 30 Nov 2021 15:42:43 +0800
Message-ID: <20211130074259.1271965-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf47136-65ec-4895-eff0-08d9b3d51788
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-Microsoft-Antispam-PRVS: <DM6PR12MB431485443B2041F26768ECF1E4679@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:86;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Atu8eayh+UYPWFUkES4eb5zGnTr6RQevs5IE1H7J+a+Dw+nzqlokDyZpHcNqiiczW0YvwNly8iKlEuCIpfhCCbeCmaemhHNF80Klu4Vi9xaHUa2G0GejAC8Dw5PRSxrN/RY3Do/PsxMydH39kGaBcE8wnE0Zx6YsInsqAsrRP+MI4GBvYHAUFLSBp87VhzB7Jb7HPw5VcybxXT+k5Xk921OztTbUmdqgsLNzuyYyriHiYfpch+jD1CevdxOO8PD0OrFqIW997mXUlfUrOfglEPfQidYJ/d+YX6tp1eukq1DssbQR26v2fE1UOHkwlwlY8GEPPBf+p2R2jyUTpVsx7AeZeABYXE4IdCeCRjPzefEH7xXALFOQKllJtlZTcol849g9THf87l9ad2PIkEPJz5qcbvIihCQlqfuu4k15Owui7k8ubFYa2uiwgEThyDk9ya2k+euxHZfBqBpjRIUmkmHc/2WvWQW48tYCuSoh2JI01RBsa3vZrnb9XFOJKL7jJ2W97XAgOFUtEGSQmXybMl1EuJ2bYhoxv55ofp49kpfjsxWLLSNBVngTjfEkaSLFw5pP7A/vURQVf6nttB99Dzqx8qqgDxPGibD5IXzIiatDl9RMS8o8eSr14GuqkzBPv3kSHxSrGYMPa4NzjW7DLbZIx9Ud8/Y/x9pNRGH4blQNTOzvAwVbdOzIK1TKmfu2hK2yfV0VRauouFrnFOUQe80r17V6N5gM4+8QynRVQVppvGPMDelyhNsd8C9wlFXKrBa4lRlj6trU5DbsTiBhQldk53Awe1nBFUq9I3Tdgs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(44832011)(16526019)(336012)(186003)(19627235002)(6916009)(86362001)(2906002)(82310400004)(2616005)(426003)(40460700001)(36756003)(36860700001)(54906003)(316002)(26005)(1076003)(8936002)(81166007)(47076005)(8676002)(83380400001)(30864003)(4326008)(5660300002)(70206006)(356005)(7696005)(508600001)(6666004)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:25.3462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf47136-65ec-4895-eff0-08d9b3d51788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those implementation details(whether swsmu supported, some ppt_funcs supported,
accessing internal statistics ...)should be kept internally. It's not a good
practice and even error prone to expose implementation details.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ibca3462ceaa26a27a9145282b60c6ce5deca7752
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 25 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 18 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  7 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  2 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  4 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 95 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 25 ++++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  9 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 ++--
 13 files changed, 155 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index bcfdb63b1d42..a545df4efce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -260,7 +260,7 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->resume(adev);
 
 	/* Wait for FW reset event complete */
-	r = smu_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
+	r = amdgpu_dpm_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to get response from firmware after reset\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 164d6a9e9fbb..0d1f00b24aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1585,22 +1585,25 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, &min_freq, &max_freq);
-		if (ret || val > max_freq || val < min_freq)
-			return -EINVAL;
-		ret = smu_set_soft_freq_range(&adev->smu, SMU_SCLK, (uint32_t)val, (uint32_t)val);
-	} else {
-		return 0;
+	ret = amdgpu_dpm_get_dpm_freq_range(adev, PP_SCLK, &min_freq, &max_freq);
+	if (ret == -EOPNOTSUPP) {
+		ret = 0;
+		goto out;
 	}
+	if (ret || val > max_freq || val < min_freq) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK, (uint32_t)val, (uint32_t)val);
+	if (ret)
+		ret = -EINVAL;
 
+out:
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
-	if (ret)
-		return -EINVAL;
-
-	return 0;
+	return ret;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1989f9e9379e..41cc1ffb5809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2617,7 +2617,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 	if (adev->asic_type == CHIP_ARCTURUS &&
 	    amdgpu_passthrough(adev) &&
 	    adev->gmc.xgmi.num_physical_nodes > 1)
-		smu_set_light_sbr(&adev->smu, true);
+		amdgpu_dpm_set_light_sbr(adev, true);
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
 		mutex_lock(&mgpu_info.mutex);
@@ -2857,7 +2857,7 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 	int i, r;
 
 	if (adev->in_s0ix)
-		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
+		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D3Entry);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -3982,7 +3982,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		return 0;
 
 	if (adev->in_s0ix)
-		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
+		amdgpu_dpm_gfx_state_change(adev, sGpuChangeState_D0Entry);
 
 	/* post card */
 	if (amdgpu_device_need_post(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1916ec84dd71..3d8f82dc8c97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -615,7 +615,7 @@ int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value)
 
 	mutex_lock(&adev->gfx.gfx_off_mutex);
 
-	r = smu_get_status_gfxoff(adev, value);
+	r = amdgpu_dpm_get_status_gfxoff(adev, value);
 
 	mutex_unlock(&adev->gfx.gfx_off_mutex);
 
@@ -852,19 +852,3 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
 	}
 	return amdgpu_num_kcq;
 }
-
-/* amdgpu_gfx_state_change_set - Handle gfx power state change set
- * @adev: amdgpu_device pointer
- * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
- *
- */
-
-void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
-{
-	mutex_lock(&adev->pm.mutex);
-	if (adev->powerplay.pp_funcs &&
-	    adev->powerplay.pp_funcs->gfx_state_change_set)
-		((adev)->powerplay.pp_funcs->gfx_state_change_set(
-			(adev)->powerplay.pp_handle, state));
-	mutex_unlock(&adev->pm.mutex);
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f851196c83a5..776c886fd94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -47,12 +47,6 @@ enum amdgpu_gfx_pipe_priority {
 	AMDGPU_GFX_PIPE_PRIO_HIGH = AMDGPU_RING_PRIO_2
 };
 
-/* Argument for PPSMC_MSG_GpuChangeState */
-enum gfx_change_state {
-	sGpuChangeState_D0Entry = 1,
-	sGpuChangeState_D3Entry,
-};
-
 #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
 #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
 
@@ -410,5 +404,4 @@ int amdgpu_gfx_cp_ecc_error_irq(struct amdgpu_device *adev,
 uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg);
 void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
-void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3c623e589b79..35c4aec04a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -901,7 +901,7 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 	 * choosing right query method according to
 	 * whether smu support query error information
 	 */
-	ret = smu_get_ecc_info(&adev->smu, (void *)&(ras->umc_ecc));
+	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(ras->umc_ecc));
 	if (ret == -EOPNOTSUPP) {
 		if (adev->umc.ras_funcs &&
 			adev->umc.ras_funcs->query_ras_error_count)
@@ -2132,8 +2132,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 		if (ret)
 			goto free;
 
-		if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
-			adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
+		amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
 	}
 
 #ifdef CONFIG_X86_MCE_AMD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 6e4bea012ea4..5fed26c8db44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -97,7 +97,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 	int ret = 0;
 
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-	ret = smu_get_ecc_info(&adev->smu, (void *)&(con->umc_ecc));
+	ret = amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
 	if (ret == -EOPNOTSUPP) {
 		if (adev->umc.ras_funcs &&
 		    adev->umc.ras_funcs->query_ras_error_count)
@@ -160,8 +160,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 						err_data->err_addr_cnt);
 			amdgpu_ras_save_bad_pages(adev);
 
-			if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
-				adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
+			amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_control.ras_num_recs);
 		}
 
 		amdgpu_ras_reset_gpu(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index deae12dc777d..329a4c89f1e6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -222,7 +222,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 
 	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
-		       atomic64_read(&dev->adev->smu.throttle_int_counter));
+		       amdgpu_dpm_get_thermal_throttling_counter(dev->adev));
 
 	add_event_to_kfifo(dev, KFD_SMI_EVENT_THERMAL_THROTTLE,	fifo_in, len);
 }
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 5c0867ebcfce..2e295facd086 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -26,6 +26,10 @@
 
 extern const struct amdgpu_ip_block_version pp_smu_ip_block;
 
+enum smu_event_type {
+	SMU_EVENT_RESET_COMPLETE = 0,
+};
+
 struct amd_vce_state {
 	/* vce clocks */
 	u32 evclk;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 08362d506534..9b332c8a0079 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1614,3 +1614,98 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 
 	return 0;
 }
+
+int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable)
+{
+	return smu_set_light_sbr(&adev->smu, enable);
+}
+
+int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
+{
+	int ret = 0;
+
+	if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->send_hbm_bad_pages_num)
+		ret = adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, size);
+
+	return ret;
+}
+
+int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
+				  enum pp_clock_type type,
+				  uint32_t *min,
+				  uint32_t *max)
+{
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case PP_SCLK:
+		return smu_get_dpm_freq_range(&adev->smu, SMU_SCLK, min, max);
+	default:
+		return -EINVAL;
+	}
+}
+
+int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
+				   enum pp_clock_type type,
+				   uint32_t min,
+				   uint32_t max)
+{
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case PP_SCLK:
+		return smu_set_soft_freq_range(&adev->smu, SMU_SCLK, min, max);
+	default:
+		return -EINVAL;
+	}
+}
+
+int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev,
+			      enum smu_event_type event,
+			      uint64_t event_arg)
+{
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	return smu_wait_for_event(&adev->smu, event, event_arg);
+}
+
+int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
+{
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	return smu_get_status_gfxoff(&adev->smu, value);
+}
+
+uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev)
+{
+	return atomic64_read(&adev->smu.throttle_int_counter);
+}
+
+/* amdgpu_dpm_gfx_state_change - Handle gfx power state change set
+ * @adev: amdgpu_device pointer
+ * @state: gfx power state(1 -sGpuChangeState_D0Entry and 2 -sGpuChangeState_D3Entry)
+ *
+ */
+void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
+				 enum gfx_change_state state)
+{
+	mutex_lock(&adev->pm.mutex);
+	if (adev->powerplay.pp_funcs &&
+	    adev->powerplay.pp_funcs->gfx_state_change_set)
+		((adev)->powerplay.pp_funcs->gfx_state_change_set(
+			(adev)->powerplay.pp_handle, state));
+	mutex_unlock(&adev->pm.mutex);
+}
+
+int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
+			    void *umc_ecc)
+{
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	return smu_get_ecc_info(&adev->smu, umc_ecc);
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 16e3f72d31b9..7289d379a9fb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -23,6 +23,12 @@
 #ifndef __AMDGPU_DPM_H__
 #define __AMDGPU_DPM_H__
 
+/* Argument for PPSMC_MSG_GpuChangeState */
+enum gfx_change_state {
+	sGpuChangeState_D0Entry = 1,
+	sGpuChangeState_D3Entry,
+};
+
 enum amdgpu_int_thermal_type {
 	THERMAL_TYPE_NONE,
 	THERMAL_TYPE_EXTERNAL,
@@ -574,5 +580,22 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
-
+int amdgpu_dpm_set_light_sbr(struct amdgpu_device *adev, bool enable);
+int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size);
+int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
+				       enum pp_clock_type type,
+				       uint32_t *min,
+				       uint32_t *max);
+int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,
+				        enum pp_clock_type type,
+				        uint32_t min,
+				        uint32_t max);
+int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
+		       uint64_t event_arg);
+int amdgpu_dpm_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
+uint64_t amdgpu_dpm_get_thermal_throttling_counter(struct amdgpu_device *adev);
+void amdgpu_dpm_gfx_state_change(struct amdgpu_device *adev,
+				 enum gfx_change_state state);
+int amdgpu_dpm_get_ecc_info(struct amdgpu_device *adev,
+			    void *umc_ecc);
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index f738f7dc20c9..29791bb21fba 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -241,11 +241,6 @@ struct smu_user_dpm_profile {
 	uint32_t clk_dependency;
 };
 
-enum smu_event_type {
-
-	SMU_EVENT_RESET_COMPLETE = 0,
-};
-
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
 	do {						\
 		tables[table_id].size = s;		\
@@ -1412,11 +1407,11 @@ int smu_set_ac_dc(struct smu_context *smu);
 
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
-int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
+int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value);
 
 int smu_set_light_sbr(struct smu_context *smu, bool enable);
 
-int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
+int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 		       uint64_t event_arg);
 int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
 int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5839918cb574..ef7d0e377965 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -100,17 +100,14 @@ static int smu_sys_set_pp_feature_mask(void *handle,
 	return ret;
 }
 
-int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value)
+int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
 {
-	int ret = 0;
-	struct smu_context *smu = &adev->smu;
+	if (!smu->ppt_funcs->get_gfx_off_status)
+		return -EINVAL;
 
-	if (is_support_sw_smu(adev) && smu->ppt_funcs->get_gfx_off_status)
-		*value = smu_get_gfx_off_status(smu);
-	else
-		ret = -EINVAL;
+	*value = smu_get_gfx_off_status(smu);
 
-	return ret;
+	return 0;
 }
 
 int smu_set_soft_freq_range(struct smu_context *smu,
@@ -3167,11 +3164,10 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.get_smu_prv_buf_details = smu_get_prv_buffer_details,
 };
 
-int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
+int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 		       uint64_t event_arg)
 {
 	int ret = -EINVAL;
-	struct smu_context *smu = &adev->smu;
 
 	if (smu->ppt_funcs->wait_for_event) {
 		mutex_lock(&smu->mutex);
-- 
2.29.0

