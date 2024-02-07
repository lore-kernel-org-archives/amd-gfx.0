Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9159EC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C6D10E15A;
	Wed,  7 Feb 2024 20:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZF04Y0Iw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D8610E15A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:41:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF8YA1YnPTw/xtgUgpWMH3DG0FSvg5MEIlJJ0jIatonPn7dLYeXjaW7fDduE0XkBiFsiLuChnLVIc7XTvhJM53TQLVkhxMPdKq2DSLCH7sGGTUKk7YVObon4pHRyomq+sQX5xSdWun9XHEpNnGIJoB7tdFop02Fc0ZC1EaC/qFnjmbD+DeRZ3iUBDyaoLnvI/2U3fsGW2/qy8OG+HshRUicoaCjfjEyxqHBiYrTWH17yAjdMiWARjzUbVmYU8CGUWO5j9QUwOyNVSUeVDIDkXeZ0A2KDhPyCNph9bkpoGtDt5GEUEsoPeUoRAGRJTT3CWuFntZJZK4aNZftESnEiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te8VxijM3CF2FhkM21anTlIhOvEygbOCfuJDn9fsQOg=;
 b=KcteAWowhcVuD7LlldlO67ivemi6mhmI6tAtoFl+BELHGdAacWgsERj0zDTEHHvAeOdD5+FEMN9uuBR790xL+IG+iSVJek1/Imkzrr4oBa5YxLNioKtQriV45z2HuN4pwPKm77krZFWsiBSbeH4iHUkn4nLRqNbBaviyHSQ6Fr+eURWE9Di6/zrCqblTYpt1Nxf4CcLS8OlIiTBGnoNVTwylUi5UcR1v69u1LNJciZNPyMnVQe3VqEMk710j9fpftOpuunYXi0POfumxJ6NAq/8IwGOIeERzn2OOiqtAizOb0pYbuvK/zNmln7NDn/IsUXunU26MDPz9JbKRfsiLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te8VxijM3CF2FhkM21anTlIhOvEygbOCfuJDn9fsQOg=;
 b=ZF04Y0IwTwvrMTrReW3ozIp6eJwM598WOidVHh378efI24xZl+ZaAmQRUV+USZ89Ye1okiJ51AJ7N3QE3NU/k0ZUlmW/f539QjcM7NcQBVmcp5zzv6G8kdq+6Xk09vvRR7l+wrdls1CDrJdTw/do/6b5Myt4U/odavtf+dd7CQE=
Received: from BL0PR1501CA0014.namprd15.prod.outlook.com
 (2603:10b6:207:17::27) by SJ1PR12MB6097.namprd12.prod.outlook.com
 (2603:10b6:a03:488::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 20:41:16 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:207:17:cafe::7b) by BL0PR1501CA0014.outlook.office365.com
 (2603:10b6:207:17::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 20:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:41:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:41:13 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH v2 2/2] drm/amd: Stop evicting resources on APUs in suspend
Date: Wed, 7 Feb 2024 14:41:03 -0600
Message-ID: <20240207204103.82789-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207204103.82789-1-mario.limonciello@amd.com>
References: <20240207204103.82789-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f61e5d-0f2c-46e3-3447-08dc281d2171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbebXY8Px/vd+gxHxTCmGgOelpwoS+C6bWrRo7oLhXUlWR5UAWZ0qbo1yregwv++o4tCmpo+yZugzUTVuPF0TRYe2Pyz2JQ6AV/76gyzI5nH9w6rk7b91VNV7PYMpIz4tPQuBEjTBNKrlWworYoRmba+U/TcmSkwkfsn3oGEUhzA847NQWcggQsxNg5Ay1tyhqNW3FEe1Eqa4QFQ+f3OweJOJibs8YageQyKirE4Nl1YvUS7eOHhIp+wlm90IPUjv2E3oRqg8HfrW69kLPoYrLtC34DLAjJ9IJ2hz5mtK2NvbVP3Qgt7M7wTgCC2iT2s8CB8Noc/5orGwhp4RN/i7h9ZZMoPJH8HqCKDy6fk2m3Pnwf39BM2sSV9VWYOQVO3QXbx35J0ZiUmRBfRRBndl0CbiJYil2PVH1hSIpYSgEy+w4lQGa8W/gnXfJaqT8JlMfi8fPkYyDbSEPP+oO7W/LJDLBV4aXUJnq6Xiut5bzxNzabgdPR/VWdUXjSt3x0W4fH0WXfVXdWDbP7H+7Tz4YtlrmNbQO5dTqlvuiPnY1duyig8fDW4U0BissOldSTkM7C7HDDp0Y9McMHcXTKD7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(478600001)(26005)(336012)(356005)(16526019)(2616005)(15650500001)(316002)(81166007)(83380400001)(82740400003)(1076003)(66574015)(4326008)(8936002)(8676002)(2906002)(70206006)(6916009)(5660300002)(6666004)(70586007)(426003)(54906003)(44832011)(7696005)(36756003)(86362001)(966005)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:41:15.7810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f61e5d-0f2c-46e3-3447-08dc281d2171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
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

commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
intentionally moved the eviction of resources to earlier in the suspend
process, but this introduced a subtle change that it occurs before adev->in_s0ix
or adev->in_s3 are set. This meant that APUs actually started to evict
resources at suspend time as well.

Add a new `in_prepare` flag that is set for the life of the prepare() callback
to return the old code flow. Drop the existing call to return 1 in this case because
the suspend() callback looks for the flags too.

Also, introduce a new amdgpu_device_freeze() function to call at S4 and evict
resources in this callback so that APUs will still get resources evicted.

Reported-by: Jürg Billeter <j@bitron.ch>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2271038
Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add and use new in_prepare member
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++--------
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d5be3e20687..f9db09a9017a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1075,7 +1075,8 @@ struct amdgpu_device {
 	u8				reset_magic[AMDGPU_RESET_MAGIC_NUM];
 
 	/* s3/s4 mask */
-	bool                            in_suspend;
+	bool				in_prepare;
+	bool				in_suspend;
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
@@ -1462,6 +1463,7 @@ int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
 int amdgpu_device_prepare(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
+int amdgpu_device_freeze(struct drm_device *drm_dev);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
 int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
 void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2bc460cb993d..0a337fcd89b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4492,7 +4492,7 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 	int ret;
 
 	/* No need to evict vram on APUs for suspend to ram or s2idle */
-	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
+	if ((adev->in_prepare) && (adev->flags & AMD_IS_APU))
 		return 0;
 
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
@@ -4521,10 +4521,12 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
+	adev->in_prepare = true;
+
 	/* Evict the majority of BOs before starting suspend sequence */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		return r;
+		goto unprepare;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -4533,10 +4535,46 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->prepare_suspend((void *)adev);
 		if (r)
-			return r;
+			goto unprepare;
 	}
 
-	return 0;
+unprepare:
+	adev->in_prepare = FALSE;
+
+	return r;
+}
+
+/**
+ * amdgpu_device_freeze - run S4 sequence
+ *
+ * @dev: drm dev pointer
+ *
+ * Prepare to put the hw in the S4 state (all asics).
+ * Returns 0 for success or an error on failure.
+ * Called at driver freeze.
+ */
+int amdgpu_device_freeze(struct drm_device *drm_dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
+
+	adev->in_s4 = true;
+
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		goto cleanup;
+
+	r = amdgpu_device_suspend(drm_dev, true);
+	if (r)
+		goto cleanup;
+
+	if (amdgpu_acpi_should_gpu_reset(adev))
+		r = amdgpu_asic_reset(adev);
+
+cleanup:
+	adev->in_s4 = false;
+
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b74f68a15802..fc9caa14c9d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2456,6 +2456,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
@@ -2464,13 +2465,6 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    pm_runtime_suspended(dev))
 		return 1;
 
-	/* if we will not support s3 or s2i for the device
-	 *  then skip suspend
-	 */
-	if (!amdgpu_acpi_is_s0ix_active(adev) &&
-	    !amdgpu_acpi_is_s3_active(adev))
-		return 1;
-
 	return amdgpu_device_prepare(drm_dev);
 }
 
@@ -2488,6 +2482,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
+
 	if (!adev->in_s0ix && !adev->in_s3)
 		return 0;
 	return amdgpu_device_suspend(drm_dev, true);
@@ -2528,18 +2523,8 @@ static int amdgpu_pmops_resume(struct device *dev)
 static int amdgpu_pmops_freeze(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
-	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	int r;
-
-	adev->in_s4 = true;
-	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_s4 = false;
-	if (r)
-		return r;
 
-	if (amdgpu_acpi_should_gpu_reset(adev))
-		return amdgpu_asic_reset(adev);
-	return 0;
+	return amdgpu_device_freeze(drm_dev);
 }
 
 static int amdgpu_pmops_thaw(struct device *dev)
-- 
2.34.1

