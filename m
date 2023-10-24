Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF08C25B48
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 14:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B8710E3D2;
	Tue, 24 Oct 2023 14:49:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB80610E3CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 14:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpS96gO+h5SvcyibocoLc1ButbOLKMJtcKpOiv8ed2PWkPU14pflDH9wv3yBMSJ3laiAK+R6eWQRZljsB5vdjyEUXmH+1lDR5ApT/MNrdYy3dk0xiAXZ2078VMd+fHbHnjP9kzrQJJyqoCJeaEyuQZiAPPAUWXSf6/vBlwJC4/tJn8QRuEJ1OdNIN6Te2/yl6JDI+PZRN3rlaCRXLLocOL5TsbQyfc6+/itaDItIQDGKUXNahkBmpox3XsmYGCKfCtUwl33zqUMmnGHx2l2SbeznKgfpAP+SkqU2GZ1vAU63Bx7rveTNBd/CqumQBE48bPFZWESPxRuxvVES6et01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl3cwa4/ve0sIHfXaDwNgJzTgCzwMVSVQxdNzy5Qh8w=;
 b=fwVrQCIlb/y85lqic7TQHFyFZ0RjuOfZpan6BKyqvNi+AiEnqtUM/YBP5of+P23rL3l03oMbm6Mtmqc8V0M4FfA5CUl4jPqGmgidhh7F1N+FKrRU40IAenPtV9M8yNRc8R/aG9C/jG04+RulRqdFJpEYgqIBKAhiQKDMLr/WTDb3dNLh9udg8oT++ALkOhSUCbwKBWGSqb8rDPnwFaM2sqHn+NPB4Dosw/dsl9uOTgfjRoXstW6TTttQ1Wr38hQe4GYx5zf2uISiBIHKrtf22mzUdG4jVZzob98gWLfpYN4z3fHYU9HHB4nQBU+vJ9jq6Fl6vBSQ0JYUM2gTje8Q7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl3cwa4/ve0sIHfXaDwNgJzTgCzwMVSVQxdNzy5Qh8w=;
 b=IYvArOSwXi51S5hkb+aDkHqlKiCdv5h/7GTAz8XKzJb3RoYdrKjls0EWraGZ/+CqzCLKClpRIHOSt5ytoX9+fnocYworI4lYqUGvWH8Ek01PLRzyu8ieudB7/JA9XwVp5Zg4pQV1wQ0PaNTc4VrSGpmh6VpAkjgBGPuji7SSRJU=
Received: from SA9PR13CA0153.namprd13.prod.outlook.com (2603:10b6:806:28::8)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:49:48 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::f8) by SA9PR13CA0153.outlook.office365.com
 (2603:10b6:806:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.15 via Frontend
 Transport; Tue, 24 Oct 2023 14:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:49:48 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 24 Oct 2023 09:49:45 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <yifan1.zhang@amd.com>, <kenneth.feng@amd.com>, <Mario.Limonciello@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: optimize RLC powerdown notification on
 Vangogh
Date: Tue, 24 Oct 2023 22:49:34 +0800
Message-ID: <22f555d910959a9eacc915afbb1c8201c564fc35.1698158958.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
References: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 27238ac7-3d52-4e4d-c2ef-08dbd4a07847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0yRMS11eLgyh2/UYtjy2tKrxckif1ErejOYc7eyfbvx9bw2SdSY280x9bxjt4x1xjKdQRHtpoc6AqEd8RKYRGPFAuHgOayARCosITpnmQHzT2mlYPaWIno2b1jonnuQJ+zBFXL6fkJY6fKvOkHp3D3qsLc6/7XAU8dkWcb8zKA7u2IRwmZtqTfqS0r3cnAesapNeaNDHbLXHV5MWKVrPyZP9R28vQDyD5NVcUKCms1UVkMdCJwd97xFTXjQTOTtEafkuL2qbfUfzuhuXoLQCxQA3vNAeh0JN+X4ekFajFhq5sNCbLh/CNQBCpCSsSqY2DCM+6q/uJz2e7+LazNFtNNoIfxIwz/BQMwEd+5uH1UHxyoE4NXmirRTUpHWwY1afInUYhNktnpz+JHZCgis2bSCqb37M6q26Ew/4uCWh/+rb5NSm4/412F/Ffe77yDSp7cOb03XZtl+WFx7l7QJrpj8NNZ+4fIMAljRTjeFaFc7f16xNoGYwxz/7kRv9T4jNWY40k3GT+7sxJdWL258fWz8g7dRZV0NXEIKoC1ABgpnq9kJZxpabKaBns0FPWkqAKi3nXsRSf+TEnrqFEZNBIkqG9KFfQ+M1YbpXlwsslP1SkFht2L3Trj5o+KYCdCXE5YHo3sI66w985Kvn+4WgstBFhdTKODOqK6sHj6HVZF0ry7qbQKubAUnPjmfDbhNdL3Hl8hXnVOoGDZiTAJYrXcypSak0we3Fa4s0WL316jnW8BmXpef8KQ2ha/uta5xepvqLclr0NWfhPd+BGpspA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(6636002)(316002)(2616005)(16526019)(26005)(426003)(336012)(110136005)(70206006)(70586007)(7696005)(54906003)(83380400001)(6666004)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(41300700001)(15650500001)(40480700001)(36860700001)(36756003)(2906002)(47076005)(40460700003)(86362001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:49:48.0256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27238ac7-3d52-4e4d-c2ef-08dbd4a07847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The smu needs to get the rlc power down message to sync the rlc state
with smu, the rlc state updating message need to be sent at while smu
begin suspend sequence , otherwise SMU will crash while RLC state is not
notified by driver, and rlc state probally changed after that
notification, so it needs to notify rlc state to smu at the end of the
suspend sequence in amdgpu_device_suspend() that can make sure the rlc
state  is correctly set to SMU.

[  101.000590] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
[  101.000598] amdgpu 0000:03:00.0: amdgpu: Failed to disable gfxoff!
[  110.838026] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
[  110.838035] amdgpu 0000:03:00.0: amdgpu: Failed to disable smu features.
[  110.838039] amdgpu 0000:03:00.0: amdgpu: Fail to disable dpm features!
[  110.838040] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62
[  110.884394] PM: suspend of devices aborted after 21213.620 msecs
[  110.884402] PM: start suspend of devices aborted after 21213.882 msecs
[  110.884405] PM: Some devices failed to suspend, or early wake event detected

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  4 ++++
 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  5 +++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  5 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h    |  1 +
 8 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cc047fe0b7ee..be08ffc69231 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4428,6 +4428,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
+	r = amdgpu_dpm_notify_rlc_state(adev, false);
+	if (r)
+		return r;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 3201808c2dd8..4eacfdfcfd4b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -444,6 +444,7 @@ struct amd_pm_funcs {
 				   struct dpm_clocks *clock_table);
 	int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
 	void (*pm_compute_clocks)(void *handle);
+	int (*notify_rlc_state)(void *handle, bool en);
 };
 
 struct metrics_table_header {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index acf3527fff2d..ed7237bb64c8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -181,6 +181,24 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
+{
+	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	if (pp_funcs && pp_funcs->notify_rlc_state) {
+		mutex_lock(&adev->pm.mutex);
+
+		ret = pp_funcs->notify_rlc_state(
+				adev->powerplay.pp_handle,
+				en);
+
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
 bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index feccd2a7120d..482ea30147ab 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -415,6 +415,8 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
 int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state);
 
+int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
+
 int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
 
 int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a0b8d5d78beb..a8fb914f746b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1710,6 +1710,16 @@ static int smu_disable_dpms(struct smu_context *smu)
 		}
 	}
 
+	/* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
+	 * otherwise SMU will hang while interacting with RLC if RLC is halted
+	 * this is a WA for Vangogh asic which fix the SMU hang issue.
+	 */
+	ret = smu_notify_rlc_state(smu, false);
+	if (ret) {
+		dev_err(adev->dev, "Fail to notify rlc status!\n");
+		return ret;
+	}
+
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
 	    !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
 		adev->gfx.rlc.funcs->stop(adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 839553a86aa2..7778a98f192c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1359,6 +1359,11 @@ struct pptable_funcs {
 	 *                       management.
 	 */
 	int (*dpm_set_umsch_mm_enable)(struct smu_context *smu, bool enable);
+
+	/**
+	 * @notify_rlc_state: Notify RLC power state to SMU.
+	 */
+	int (*notify_rlc_state)(struct smu_context *smu, bool en);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 3efc6aed28f1..b42771471416 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2202,8 +2202,7 @@ static int vangogh_get_dpm_clock_table(struct smu_context *smu, struct dpm_clock
 	return 0;
 }
 
-
-static int vangogh_system_features_control(struct smu_context *smu, bool en)
+static int vangogh_notify_rlc_state(struct smu_context *smu, bool en)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
@@ -2532,7 +2531,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.print_clk_levels = vangogh_common_print_clk_levels,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
-	.system_features_control = vangogh_system_features_control,
+	.notify_rlc_state = vangogh_notify_rlc_state,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.set_power_profile_mode = vangogh_set_power_profile_mode,
 	.get_power_profile_mode = vangogh_get_power_profile_mode,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 80b3c3efc006..64766ac69c53 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -97,6 +97,7 @@
 #define smu_get_default_config_table_settings(smu, config_table)	smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
 #define smu_set_config_table(smu, config_table)				smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
 #define smu_init_pptable_microcode(smu)					smu_ppt_funcs(init_pptable_microcode, 0, smu)
+#define smu_notify_rlc_state(smu, en)					smu_ppt_funcs(notify_rlc_state, 0, smu, en)
 
 #endif
 #endif
-- 
2.34.1

