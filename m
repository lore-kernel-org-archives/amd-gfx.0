Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BABC5DF67
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 04:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC11110E9DB;
	Tue, 18 Aug 2026 04:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m1vI731a";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF39110E9DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 04:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cmlzl+gSzdcor1SNl/XPLl/8PGjcRN4Cw8DLlg5LflRlc8conohDIjghMHz9ZPpdXIVAUp9Zuv3o5nP6tcRqRoWwPDj13WOT11+aIRAuL4VWFptoBGwplZFKgZO5pQy6fKCgBUzUu7qiVGz/v0A45ZK9pvV/gSTqxPGi0FuW3D5qBYuVUgcM2/+dqcfCfXZeACZ44wnBc8C1MSL+A1+jd2thC+cWaaXj87dF98msyv2m07l8rNrMgK2Nm21mppH4/PdaYWENt6A2QLDOU2e84UdAXdEq3UFj8f1/PHpUjbE8bIiuIW5sErZ3vvaOJ3ggn/i5nDUhHFXaucUM+8ymZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVM3DrhFlDmWIApWy+pAcbV7A6XSZQ3NPBudBdEyMxY=;
 b=yNNUhoUYtys8eAt5nZeOUy5lfYUxfBlfCXogabCItxVW1wxI1dk1/5vHTURHkpcJ365sGbrY3GCaGxPdjJdoZbz2QVhkwjgBCXpr2XjjJoOLBMYGsBv7g+pBvVgWxbd1lATVnDtKlrXEIbYiSDT9OHJCLwVsrlI8gODNF6MbLfgQlWQT/RCnT9SZvCMQBtoUhOaxUoeR7kvGYkMxNAs8dxLKmCxa8EH2EhRcWey6zukilyLJmLTtXMuvydTLa1zkTmNjwHhxdAnYclKk7EioBrtF9eXLhHZxMW6eLBd8E7eO0D6tYrUSNVmM38zy8lbGMmu2DYW1fVYQ5MzvW1YLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVM3DrhFlDmWIApWy+pAcbV7A6XSZQ3NPBudBdEyMxY=;
 b=m1vI731a+wZUd1r+EayUYpsgAwiFdhpR29E8r/WhvjuIV5HyOpkD/St74xRgWuotibUAtSXhHXIN1+kETMWGXgpsDNyZHhgNBgVpZnBsNQYbi+BF2JeZ25CcNdm6r1n/+WgZPZTWcZ1EvIalc9lLc05XMIP1mAm+4A/WudZu8vE=
Received: from PH3PEPF000040AE.namprd05.prod.outlook.com (2603:10b6:518:1::59)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 04:20:39 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2a01:111:f403:c903::2) by PH3PEPF000040AE.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 04:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 04:20:38 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 23:20:36 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: Fix SMU messages after system resume for smu
 11.0.x
Date: Tue, 18 Aug 2026 12:20:08 +0800
Message-ID: <20260818042008.287779-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cbc1d3b-fd6f-42b5-4b6f-08defce00f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|56012099006|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 70lYu+LVm6ltKOxhabsw0EgiqZ6mUjPJfUpHCc+1bsn4V+yGU3sVVZSX8uhi4Aj7ut+E8tN8j1I9WdsuVanilX35+LwLEUtM5xEVSdqqEo3OctUV+wL87g06WUHb9WKYUlTHMeoLqF6FnxI1nf6ODQG2kvL2gX2vvGZCmTYpVrOe3aNzI2vRLDlHkEozVGjSLUGpzlA7Fq+t7gUOlxKmDf9stxcvgHMx+lVOYk8nVsBS0bN51z6lbLePMeOxIAKnQbSL7Qks4Ap6qkTP/uUdENfKd7mZOma3eiuwbc8gTeKx1Gqtk0KZsdcBvVkH+qgP111/WP5/c0eagYQwSBGzpGDPClJUSfzdC8XLkrwmqbM+EEUFhOwO/cPxUAjCG0N6CF1FnuRAoNeJ0rHIPEnzdg0cIQxxvT9NDZUEDycE9HwWRw9IbTwdPYW+xHbP8QeLjL9ETwjSQU8vPJ0e9yswBzlAOyDQ7b9kVTTC95M+nTEEezKhFgZONKw2PMc+GInZcbGTWn6AczPOxxrWbcNGFCB6ufkpW/iPqq6g9sVXS4djOn57mVVPB/nkVVzmfJ81n+8oRDdSZscksPre8OTo8mFje1C2wX/+0RMGslrHaHqkTTwsTxBVmssTUzrgFx9HDL58YPUkLJLN+UuM2OXC7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(11063799006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FQT3eSW8tu5A+9g3rKESjFVYKR0g9nUGGkGWXdRQGmB0OmQ9/o+Hhs6SYCqldtH9yfGBvQmJYxK1XhTO7TNQFAKkrHAXE4VBOn0CAXAEeytJ2Cc7ozvdrArHoD82xrzk2X11WhDay4dI7zCL3VS37KjqVOLYLVrS9ZzETJxV/sXxS7F565sEilUzkvCbEGBgbmf7nKhsAsO2vgBWZdcf8dk19UxRVmwCadPJBXibxyauZDgj0R3g3k3J3cnm0OAxM92NVExKW+JihCWTSRpN1xuiM3vgAlAvbTY04uNAWd9b2xjBXJm3lk0CF+ufvj+nU4UJT5E6eHIrKPMJh8iaRNpQXK2GkBPQMN2O7I+kTAxrtaCsy+27O1/Py0ddfdjTIziog8Me/AbR/PI1B6nzyFJeTssxnfZ9tQjys8pKGraEAxuijAPnLX3/KZnCs8EN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 04:20:38.9384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbc1d3b-fd6f-42b5-4b6f-08defce00f30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU 11.0.x can retain an unfinished command across system
suspend, causing SMU messages such as RunDcBtc to fail during resume.

The original failure path is:

amdgpu_pmops_resume()
`-- amdgpu_device_resume()
    `-- amdgpu_device_ip_resume()
        `-- smu_resume()
            `-- smu_smc_hw_setup()
                `-- smu_run_btc()
                    `-- RunDcBtc fails

v1:
- Prepare MP1 for unload for an active system suspend.
- Restore PMFW context after the normal PSP resume load. The initial
  centralized load preserves PMFW-before-TMR ordering; a successful MP1
  unload additionally requires the post-TMR context reload.

v2:
- Snapshot the runtime PM state at system-suspend entry.
- Exclude runtime-suspended BACO entries from the MP1 unload and PMFW
  recovery transaction.
- Mark the successful MP1 unload in PSP to order the post-TMR reload.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5620
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 11 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 11 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 40 ++++++++++++++++++++---
 5 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 070986b03fb8..71606dd2d6fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -860,6 +860,8 @@ struct amdgpu_device {
 
 	/* s3/s4 mask */
 	bool                            in_suspend;
+	/* runtime PM state snapshot at system-suspend entry */
+	bool				in_runpm_at_suspend;
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 845160d2c516..8c7df6b4e168 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2803,10 +2803,15 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
+	adev->in_runpm_at_suspend = false;
+
 	/* device maybe not resumed here, return immediately in this case */
 	if (adev->in_s4 && adev->in_suspend)
 		return 0;
 
+	/* System PM can change runtime PM state after this callback. */
+	adev->in_runpm_at_suspend = pm_runtime_suspended(dev);
+
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
@@ -2825,7 +2830,11 @@ static int amdgpu_pmops_prepare(struct device *dev)
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
-	amdgpu_device_complete(dev_get_drvdata(dev));
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	amdgpu_device_complete(drm_dev);
+	adev->in_runpm_at_suspend = false;
 }
 
 static int amdgpu_pmops_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04f6ebf31cca..e252733a6f3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3512,11 +3512,18 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp->autoload_supported &&
-	    !psp->pmfw_centralized_cstate_management) {
+	/*
+	 * NOTE: The centralized PMFW load in psp_hw_start() must precede
+	 * TMR setup. A successful MP1 unload also requires PMFW context
+	 * recovery after TMR, so reload it for this transaction here.
+	 */
+	if (psp->smu_fw_post_tmr_reload ||
+	    (psp->autoload_supported &&
+	     !psp->pmfw_centralized_cstate_management)) {
 		ret = psp_load_smu_fw(psp);
 		if (ret)
 			return ret;
+		psp->smu_fw_post_tmr_reload = false;
 	}
 
 	/* Load P2S table first if it's available */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d80c85793e3b..540077b9f070 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -443,6 +443,8 @@ struct psp_context {
 	bool				boot_time_tmr;
 	/* flag to mark whether df cstate management centralized to PMFW */
 	bool				pmfw_centralized_cstate_management;
+	/* SMC firmware reload required after TMR during system resume */
+	bool				smu_fw_post_tmr_reload;
 
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 559afdc5815d..8ff1cb1efc5b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2182,12 +2182,38 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 static int smu_reset_mp1_state(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	u32 mp1_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
+	bool needs_mp1_unload;
+	int ret;
 
-	if ((!adev->in_runpm) && (!adev->in_suspend) &&
-		(!amdgpu_in_reset(adev)) && !smu->is_apu &&
-			amdgpu_ip_version(adev, MP1_HWIP, 0) >= IP_VERSION(13, 0, 0))
-		ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+	if (adev->in_runpm || amdgpu_in_reset(adev) || smu->is_apu)
+		return 0;
+
+	switch (mp1_version) {
+	case IP_VERSION(11, 0, 7):
+	case IP_VERSION(11, 0, 11):
+	case IP_VERSION(11, 0, 12):
+	case IP_VERSION(11, 0, 13):
+		/*
+		 * Prepare MP1 only for an active system-suspend entry.
+		 * BACO retains the SMU firmware across runtime suspend.
+		 */
+		needs_mp1_unload = adev->in_suspend &&
+			!adev->in_runpm_at_suspend &&
+			adev->mp1_state != PP_MP1_STATE_UNLOAD;
+		break;
+	default:
+		needs_mp1_unload = !adev->in_suspend &&
+			mp1_version >= IP_VERSION(13, 0, 0);
+		break;
+	}
+
+	if (!needs_mp1_unload)
+		return 0;
+
+	ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+	if (!ret && adev->in_suspend)
+		adev->psp.smu_fw_post_tmr_reload = true;
 
 	return ret;
 }
@@ -2279,6 +2305,10 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
 	if (ret)
 		return ret;
 
+	ret = smu_reset_mp1_state(smu);
+	if (ret)
+		return ret;
+
 	smu->watermarks_bitmap &= ~(WATERMARKS_LOADED);
 
 	smu_set_gfx_cgpg(smu, false);
-- 
2.54.0

