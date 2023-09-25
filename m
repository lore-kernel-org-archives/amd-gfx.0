Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270D2CE7A8C
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 04:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8784F10E1D6;
	Mon, 25 Sep 2023 04:28:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE8610E1D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 04:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtUUZ5nN78msHkbIvmElJ309N0M1ZF+Vfl4C4xRmmXmk7fw2oYSSG1kRTymoXZmm3VO26Rye+zO1sbhP5U04guSntdzV0bbxUT6hwRLu9aa7hRmGupdT1Z3PgI2MYJ95cX1JcAgYfr3okZyrEJlFenhTunLOuKzJiF36CmOJEL2B8K/5xYO6nXGq3BcGlXyWAfd6mrdqvRbQ3hpIbXzQZ7JfwefGp2PAJQ3U1r1yNjyAZfCavUBlb4CJizIViVxe5Z6jQ0i3GbrLIgwHf+azBQ2o4P8Dv6wmn/Q1DKsMt7O0VP5h6Pb0V1+ooVaXbnCYPP/cQK1kHErmM8kO86bQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiV3aL7igzEBMoH2V2ZSJ9oXFY2A38WLA5JBxF0cMXA=;
 b=neadmwGoAD6FXezzh36ovvNjQTkg/x3RfXkvuVNFrCsCK3TBsBUiv655ccxyLKFITEiuTpshYXjd+toIyJLMy34NmBFylE7h2/pjDHTl14DCibPpZhK3F9Fyth7aqVvegrah5a0RZnHPoyFl3kT3CLk8fHGyt8oexUsY7zuw71Zhj/NNoR7NPIDzimyplLJKNQqYaGLErEdC2w1x8zM6paEuksBzjzo6TNuJaMe5hhlrN9IcNwfPRDIwffxatG8fng34odLS4+IuiTlVb/9qs852NI15+92KHAeRmc7N2/mHevBaJBj6gWdtwJEaRghTwnSc4nmvWbO09NdzvNWaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiV3aL7igzEBMoH2V2ZSJ9oXFY2A38WLA5JBxF0cMXA=;
 b=4NB9aYquC5YKMS41nMNwQ6ptPQeB+orauHr2eEEPBYn6rSV13Sh9EIkhAC3y2ZydChNI91k+guH80Nz3tzjYYiboK46ceTZs+3Om4DI0AYTNa76M1K9soNR6j8sYoMP0QePcMP9AVw07iNpB04aYnfjLkMDZuTQ5N802dokxrcA=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 04:28:54 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::55) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 04:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 04:28:53 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Sep
 2023 23:28:51 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amd/pm: deprecate allow_xgmi_power_down interface
Date: Mon, 25 Sep 2023 12:27:52 +0800
Message-ID: <20230925042752.3847-7-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230925042752.3847-1-le.ma@amd.com>
References: <20230925042752.3847-1-le.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 054a97b1-1b71-41f6-a756-08dbbd7fece9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eo3IWL6qie328YM/n/M6WgLANQKzniD1L029Q/Fi3o4ydRz7WXv61CBTOYjNTE2Yv5QveTAqHrKftKN486uOfbu8HD50xdW7qo3vcxFRl8etu7IpzojjkerGw2jVwas+f7gPHJpGpHHNJFWvJRNX/ILEHtrOoRfSCtOwSlDbYX6ZQSRvRmgxsgn6QFJgOyj7mcTIyt4Kic8OUxLR8JoSIj9JzK+iXsHwFXKy7MfcBKjysKMQP8T75RR/6RlIZOsQdskXXgY/2EG8HOTVglx8CWBsnQG6+qU0RUSQJeHHEMxN0zoEQRnQtVB9/mhqdBE6sXjmTHrC22IecsImyRPDCDLylc6tT6hBktLnAoRBarR6jyX4uLiZ1/+1ooI5TDUJc1xxcRwumP4YIzMzrItuSJE7kq8SH304URRTAH716t1J6L48ABNoKXOxK+dE7KxIsuiU9W4dU63jnl4OjfELDQnpz+eYIM7AhZLXd37Jv/wWwTn+OFDSzEmCGqUcQwgtFSxI0fTBO3dn5hRy+LrDDUi3U9ulBq0yFsL123ctVH1lqt7EBHk4F8jGZQhkd/2Mgid2SczVwRb1AAf4ZKtr3cNCylNzChE+qTijuXWFDuKH9s40J+2ZQR5nrfNgy/zStQ+bgS0wmm2i3IpJpAVWfVZKpKszjefYV/pXdDgmf+bAcFYHwT044EHlVvZ5xmAqxIuCKua0/m59oA3ldpO6wKI0ICdMvbWzTawAEP2/CovVVMcDyVPQS9DiXTGPcT7tVib70IOf+UT90LQ2KACkQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39850400004)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(36860700001)(40460700003)(40480700001)(426003)(336012)(26005)(36756003)(16526019)(44832011)(5660300002)(356005)(8936002)(8676002)(4326008)(82740400003)(81166007)(2906002)(478600001)(86362001)(70206006)(70586007)(6916009)(316002)(54906003)(41300700001)(1076003)(2616005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 04:28:53.4882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054a97b1-1b71-41f6-a756-08dbbd7fece9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace with set_plpd_mode uniformly for places to use.

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  4 ++--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 14 --------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 17 -----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 --------
 5 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 061534e845a7..1fb3f1ecfa7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1072,7 +1072,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow df cstate");
 
-	if (amdgpu_dpm_allow_xgmi_power_down(adev, false))
+	if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DISALLOW))
 		dev_warn(adev->dev, "Failed to disallow XGMI power down");
 
 	ret = psp_ras_trigger_error(&adev->psp, block_info, instance_mask);
@@ -1080,7 +1080,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_ras_intr_triggered())
 		return ret;
 
-	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
+	if (amdgpu_dpm_set_xgmi_plpd_mode(adev, XGMI_PLPD_DEFAULT))
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
 	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9a157fe4cbc7..1b17a71ed45e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -351,20 +351,6 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en)
-{
-	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret = 0;
-
-	if (is_support_sw_smu(adev)) {
-		mutex_lock(&adev->pm.mutex);
-		ret = smu_allow_xgmi_power_down(smu, en);
-		mutex_unlock(&adev->pm.mutex);
-	}
-
-	return ret;
-}
-
 int amdgpu_dpm_get_xgmi_plpd_mode(struct amdgpu_device *adev, char **mode_desc)
 {
 	struct smu_context *smu = adev->powerplay.pp_handle;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 564494f29717..feccd2a7120d 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -424,8 +424,6 @@ int amdgpu_dpm_baco_enter(struct amdgpu_device *adev);
 int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 			     uint32_t cstate);
 
-int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en);
-
 int amdgpu_dpm_get_xgmi_plpd_mode(struct amdgpu_device *adev,
 				  char **mode);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c6b22638bf4..33eaf0d77163 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2178,23 +2178,6 @@ static int smu_set_df_cstate(void *handle,
 	return ret;
 }
 
-int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
-		return 0;
-
-	ret = smu->ppt_funcs->allow_xgmi_power_down(smu, en);
-	if (ret)
-		dev_err(smu->adev->dev, "[AllowXgmiPowerDown] failed!\n");
-
-	return ret;
-}
-
 int smu_write_watermarks_table(struct smu_context *smu)
 {
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e17169f681e8..4f6df3558b9b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -834,12 +834,6 @@ struct pptable_funcs {
 	 */
 	int (*set_df_cstate)(struct smu_context *smu, enum pp_df_cstate state);
 
-	/**
-	 * @allow_xgmi_power_down: Enable/disable external global memory
-	 *                         interconnect power down.
-	 */
-	int (*allow_xgmi_power_down)(struct smu_context *smu, bool en);
-
 	/**
 	 * @select_xgmi_plpd_policy: Select xgmi per-link power down policy.
 	 */
@@ -1491,8 +1485,6 @@ int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
 
 int smu_set_ac_dc(struct smu_context *smu);
 
-int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
-
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
 			   enum pp_xgmi_plpd_mode mode);
 
-- 
2.38.1

