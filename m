Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E097C5B572
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 06:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC0FD10E3B7;
	Mon, 17 Aug 2026 06:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yrr09MFa";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A529B10E3B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 06:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4Br7lRhT5TNhbys9LOoUIoBLnMVANzC+JzMmaiz/pnYdFnTRL5szjt3YzwKrS0qhcD30LRqDukWSIT2HW9+hN3Tz+aDnjnZ3N9Ldml+sHbphcOENnNIOE/nTcZgg5Qf9rZHQgVn0Xd9W40yED+aqp7+ZVr39+yPItkdgP7iUiOppgvNZRcRt0lHX7F5fpuYP52e7IkNPOiUalkwpld6RPRpqfbUp9rDq4fQ84gccmUyuO2aCTQWyJVtyhkURTx6blPD9vGgZvRNG7ehy6hqGqcz8z1eig+UbyyDp44hl8AKL7oYOQtur48bwE7ZTMVomE96i+zD8GCbh3zz+ObzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+n6YwiZ0N4i8mtt2/1A9LzqJahbbxcbPndiFuF8v/s=;
 b=zSiUAkVXD4cryRpI+Z4y+cxtkkG1SWYzW9AxN4EMR6Iw5ekO2N20fW3JmcYtvMg1OhRkMu0ANN7mQRmOXhSVdXmHXp5t6q7dF3YF98fF9FdJU4lQxbsBgB3AKAiAPThYcoAqnCmj5Wmk9YDYkafo2ndodiTDlepWrKZ/SY4VuBwjPIKe0TGbw5/7vmZBHYHKlGjGXJiCXQwKtmQ2Rl7iMOHlMseAan3AGz4Daqk34WbCu5HnBuWpRi2eS0wzBobX8fhpVjlPk+IRnQxAsNpDP3j/p7+wDa1gmIi2jp7RrHS1VmJiXMsj0YHGzJiyUCLUiZjJzqdlYbyarRIOoZXJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+n6YwiZ0N4i8mtt2/1A9LzqJahbbxcbPndiFuF8v/s=;
 b=yrr09MFahV8xw4FItEJvb1CLD/uz2K/GbN03xnff8guipcAnOCxGAEmfRqM0Pb9FUY4U1xC0+2RRJjFle4jnduq6d2D5TN6K0aORX88S4MX1iWG39enRD+uXxPk8qQcn6nQ6kY84xIBOr0GYP+4ktrSvPU6SMb1w68X9Leqr2v4=
Received: from BN0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:408:142::11)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:27:41 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::a3) by BN0PR08CA0010.outlook.office365.com
 (2603:10b6:408:142::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 06:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 06:27:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 01:27:38 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu messages after system resume for smu
 11.0.x
Date: Mon, 17 Aug 2026 14:27:28 +0800
Message-ID: <20260817062728.2535467-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 01100094-a262-4e5d-1966-08defc28a37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|56012099006|13003099007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: aHROBIJqK/VGiE8nFNG//z2x//ggJ8aPuYlbIjc5+lgaI2ziNqZS4q2oONXXNwAGiXnBaoOqZ1Pqz29i7WkFpkYEaW25oDgn0pgLVTSOGud9/wwZoPXStQAV4O4UiCfE+8EL6iqAyBtAVPg+JoGxhoZiPKYJ6tDzGWz3eBDTcOkrBKIhdXFLx9zM6MZG/1IGmhuy6aAow96gDDQ4Gs7aNqHp+TaVrmywsz5Wo2rC/9uuS73eSbJhSrHQP5D5jkI2Xd1CieIzyPZ3vpwgel7dD0Hhm+TVSq9RoIH5BMUky5tTqRdetaWjLWMEE6tt6jxVh2JYqQ4NgsKDrLDxfPZarj62XErfxWn/aPtV0vWCRliAhIQ7gxHGOFWXhoOovdoIPdr7Ywp+lr7vvwh6CQ5inuJTNmBISsVy/FeIdKpKNJI6clHZPH65N2kx9UZy68vyfA4LbPCKavounyo9sxmyd4V9OxQKJhRqQQdnY5RoJGKE7prKObbgz7wCZtA2F9huSLKZFVmyuTUJaVi2biN/4okB+CmqXnQAt08hXfj2RmpZ7AQDvrUYXDeTSA/xxzEjgpkDlj0nGEKZa3jcIuu90r2c7vxfATI6JqNLuey2gNUcQz7rZBAFB2wHz088RmS7mSU6egMkhlt75InPEnBr9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(56012099006)(13003099007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b2I2wM5Ppj6o/Lip946snVzKNedJXXLVNYWnz78ZRZz3chwbCVNM9TAQqr4hCyBVAqqY3DAzNPpPYVcBVpQz1b9T0r9cvYQl7ccmBsE8+KLsnurMRW1i9mlwXHMFxny4xfltWUKZhtLEgNPggFDlgsJ0XjeiGaxr1i3MgLs+v+8IoLSDd8NhHKRV52tgiZdHUfzn+1zmY/K36TP8Am5oZDtuWngTT1HYKqWiZzmGP6FAvz9Y448qDiYtEEnbuy2B3GFd0B0XnJv1KwgSaa+OR6NakIyUJ9c3vXHubrAjRZ8X5/NHuf3qoMPU6rvTI2ScRK30Yka+mfHnA1K5QdeavgvX8ErmezwOCqVk7N9oo4m1VoBBr0yoI5fGSpZx1MXfuU2mVNNLlx2mBeXMx5JwxW/6ovCH2zfmJd1B1Crsvk6uzpzYJ7gocmetZgE/eEEF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:27:40.4662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01100094-a262-4e5d-1966-08defc28a37f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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

Prepare MP1 for unload during system suspend and record successful completion,
reload SMC firmware after PSP restart before resume sends further SMU messages,
then clear the reload state.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5620

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  9 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 38 ++++++++++++++++++++---
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 04f6ebf31cca..5c00683c1edd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3512,11 +3512,16 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 	struct amdgpu_firmware_info *ucode;
 	struct amdgpu_device *adev = psp->adev;
 
-	if (psp->autoload_supported &&
-	    !psp->pmfw_centralized_cstate_management) {
+	if (psp->smu_fw_needs_reload ||
+	    (psp->autoload_supported &&
+	     !psp->pmfw_centralized_cstate_management)) {
+		if (psp->smu_fw_needs_reload)
+			dev_dbg(adev->dev,
+				"Reloading SMU firmware after MP1 unload\n");
 		ret = psp_load_smu_fw(psp);
 		if (ret)
 			return ret;
+		psp->smu_fw_needs_reload = false;
 	}
 
 	/* Load P2S table first if it's available */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d80c85793e3b..20338caa4921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -443,6 +443,8 @@ struct psp_context {
 	bool				boot_time_tmr;
 	/* flag to mark whether df cstate management centralized to PMFW */
 	bool				pmfw_centralized_cstate_management;
+	/* SMC firmware reload required during resume */
+	bool				smu_fw_needs_reload;
 
 	/* xgmi ta firmware and buffer */
 	const struct firmware		*ta_fw;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 559afdc5815d..8d499d9a86df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2182,12 +2182,36 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
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
+		 * These SMU versions require MP1 unload before system suspend.
+		 * The shutdown path already requests it through mp1_state.
+		 */
+		needs_mp1_unload = adev->mp1_state != PP_MP1_STATE_UNLOAD;
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
+		adev->psp.smu_fw_needs_reload = true;
 
 	return ret;
 }
@@ -2279,6 +2303,10 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
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

