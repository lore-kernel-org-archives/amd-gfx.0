Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30274D2447B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 06:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D317B10EA38;
	Fri, 11 Oct 2024 06:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CjL24GIa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A0D10EA38
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 06:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPqERRakM+6VjfU99U4V6ug3tzD5VLef5GBAp2XONJV8CPIIIuu6jKCQupa1DoIkHZkHMca0tbI6jlkxMGqCqC9+Adg4B8/UAU3EQlXlmwbNfIzf4R4CaNFTtObxCrg8rfegTQ0j9D7Sp2AbPkWqhbMUcOOTlCfhSjPvNYcKnDYOBgrchKn7uWCJUFS17XcNm2hHjKm1oxFz5GhKu11A2wVBvgofZwBtRcTkkjv+FLb7A4HL+Zbm3IIK2rMAbi2j2QfiDgTbwNbXflnRkJImYVvmvQaqwo7MtPRSPNJNpiUSbZq3D6tkbBm00MpWLhJAQBEJRs1IF6Zvn1yX3cGmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcqWVL69lK5dOOisKiFq88fMi9rf424rqvkj23XG6Jw=;
 b=Ew/Wp/+bIXKXKRbJxWE1rFPWeNXqUtawc+1jd0WvtR/hob/ZJFAHXX6D1z1yfPHMGNCC5XuI6eEBrupSBd08hW43MhBBGOnapZzaFzdBnePSdLzpiOZPkh3vLU2QnMuxp2FBztHZnLpM5UKAqAzd6sA4bUJMy0WzwFtzkv8YuvrtctfzqGvA7j/JGrCZtloqlRAwtrNf86EalWVpqUrguBa6vMnM+zoIyDilkbVXAMYw/TCQzmlWLDJjk1NLD92Iyu35btWtiaiyGyRzJcfZywyW2Ec9FYEcDAU2Vk2g66Io+7Xce385jFuUUGrolvGvBphQrtxervx9qiTN8L1mrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcqWVL69lK5dOOisKiFq88fMi9rf424rqvkj23XG6Jw=;
 b=CjL24GIaSY7i1HfxkuD/ZV+HeUADQzr8HIycqxcsWf/jevazSU657DajfdwQ0+imO4kyeoHPMk85WIGnM7MEtv8EC8cb0hrosE07MIi2kzEglWODXri2XMWMGCWkWocB+lMwjNzW8mGDGql8/BdhrvKgBtDKpAnAL3MfUMh5xWI=
Received: from MN0PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:52c::31)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 06:01:21 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:52c:cafe::2d) by MN0PR05CA0006.outlook.office365.com
 (2603:10b6:208:52c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.8 via Frontend
 Transport; Fri, 11 Oct 2024 06:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Fri, 11 Oct 2024 06:01:18 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Oct
 2024 01:01:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: clean up the suspend_complete
Date: Fri, 11 Oct 2024 14:01:06 +0800
Message-ID: <20241011060106.1745314-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011060106.1745314-1-Prike.Liang@amd.com>
References: <20241011060106.1745314-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: f94b4ff7-bcbb-4664-02b9-08dce9ba1ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p7M8qzrc8AuM5kA60srxicvxggQtKVNHiuvlF5LUqWcxWkdypScuLE9/wxWD?=
 =?us-ascii?Q?ks80tCX7O6A+w/Dk79NW9Uj2cLuL7kPhkJ9TqTEsmOEVDEEOO3w88aVAcQd+?=
 =?us-ascii?Q?wBUcMtiN6nYMSb3CBpTADV7enhTFy+VosCpNlw6l7bPpUcM++WJ6Pd8UxINO?=
 =?us-ascii?Q?nS8PD5mwKgF3kaQhpP+yzGNgzEOOhhpgr2fcw5hEYH5dFF6BfbFKGAYpH714?=
 =?us-ascii?Q?GZ74pz+GzlDd6cBNtsW5KpC9kJhFfqQT/cBzNPLirD3ft1waCoWrTD++ICm5?=
 =?us-ascii?Q?Jos4DtqjOzJ2/4FkrjLOns0k03PoP4qRLGgJInxUtw/VBRuD0u+tYN3SaVvs?=
 =?us-ascii?Q?/zy6VVrWaKBQ9bhgZQ3d7KeqDnEYEL7RO7xVtS815TG05KtCrEmXs7rDNI8C?=
 =?us-ascii?Q?GiBzXcvOk5ftMe9MWibBIeL3DnQR/eKsv+GbffxawiOlQnRcpCt9I3QHCGAq?=
 =?us-ascii?Q?diTiDRS1t6Bfdm63VrmH85lxsx0K7Lragmwi6GGUSJeHTHCpblqtUWJlzVqy?=
 =?us-ascii?Q?gOaQIwDm5JPrxYPscSVfACu5ZNzYMbDvlM7SFXUI71/Njm/IYz+/mAQVpgyK?=
 =?us-ascii?Q?VWGjp5fqwwSN4IbNsGjYxeylt+GAF2Surl2BJHIS5IiobAGEBlyYHc1j87Jo?=
 =?us-ascii?Q?oK6Kbqey4AKei+17NPHP6Dq3DR7Gzv2YHAFxrNye1PQXz9R5nvxqyn9IL0Cf?=
 =?us-ascii?Q?sNrEAlYBwlsiV90bKmOUDE2Xmt01jTsLcNOxqSATj6yU9a0kBX5pfUFwVaV5?=
 =?us-ascii?Q?3WfwJdcHcYtvBrNJYUgZJd7fZI7JZuBYHRNLGo0Eqe8cre5fJoqwAe0wxQeY?=
 =?us-ascii?Q?aNl4YB05MaN8uzMAcPeP5tzv3I/9g8XYWOenl5phwcaVXF4PNpD4Clf49nOD?=
 =?us-ascii?Q?tZ5xlIfeZt5v/BOAbEtX15dhUMO9oOwpZaLCaXC3OloVfVUWzm8ZsGamAP0p?=
 =?us-ascii?Q?9HSohZx6QaezG86J1T+CGPXFpq4/RZYyYIOTaEBnppoff0gKeToawU/JqvSO?=
 =?us-ascii?Q?/FCfXgl8G9Z3ZGVtBnLIh3XZmOoPD5F49ZPxzR0ng71eCNlQ1+ibA+SGsEuo?=
 =?us-ascii?Q?D5lLkrsKlODbB+rZo01D3wtqqXHBlqWwd6m8T5B2wb7Gd5qIHotqeZLyZocG?=
 =?us-ascii?Q?tUHmfnfLnmlpIoaq8LAG/baFsHxyvilouGW/68i1lQR33vACj4wCFJ2Te976?=
 =?us-ascii?Q?u/py0o7ie0UB/AB4gI27NF8SHEMpYTnO/A1aky/LIC1EAW7d9D/eUgakmgWX?=
 =?us-ascii?Q?2cIQD7qaxWNwWc8vV1yGpSSjZ2sLYsvss+Nua2CP4I3twK9ZTRd1RmFlX5y8?=
 =?us-ascii?Q?0vJcmvTHh4T8i4YAN2YVcfrAmcZnFunYP3fqzeVN+E7IGdhukooh6uQHwl+H?=
 =?us-ascii?Q?B/P9itQ8C44AfZjFSHy5rylwHBwK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 06:01:18.8941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f94b4ff7-bcbb-4664-02b9-08dce9ba1ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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

To check the status of S3 suspend completion,
use the PM core pm_suspend_global_flags bit(1)
to detect S3 abort events. Therefore, clean up
the AMDGPU driver's private flag suspend_complete.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 7 ++++++-
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 84a9749dcd7d..00b5f66c8f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1108,8 +1108,6 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
-	/* indicate amdgpu suspension status */
-	bool				suspend_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03c3cf3d2748..f02dcd1aef72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2499,7 +2499,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	adev->suspend_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
@@ -2514,7 +2513,6 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	adev->suspend_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fb4402f9bd8d..23df9608882a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3263,6 +3263,10 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 	const struct cs_section_def *sect = NULL;
 	const struct cs_extent_def *ext = NULL;
 	int r, i, tmp;
+	bool suspend_complete;
+
+	suspend_complete = !!(pm_suspend_global_flags &
+				PM_SUSPEND_FLAG_FW_RESUME);
 
 	/* init the CP */
 	WREG32_SOC15(GC, 0, mmCP_MAX_CONTEXT, adev->gfx.config.max_hw_contexts - 1);
@@ -3274,8 +3278,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 	 * confirmed that the APU gfx10/gfx11 needn't such update.
 	 */
 	if (adev->flags & AMD_IS_APU &&
-			adev->in_s3 && !adev->suspend_complete) {
-		DRM_INFO(" Will skip the CSB packet resubmit\n");
+			adev->in_s3 && !suspend_complete) {
+		DRM_INFO("Will skip the CSB packet resubmit\n");
 		return 0;
 	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d07cf8137bd7..5e2d3afec451 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -589,13 +589,10 @@ static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 				PM_SUSPEND_FLAG_FW_RESUME);
 
 	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!suspend_complete) {
-		adev->suspend_complete = false;
+			!suspend_complete)
 		return true;
-	} else {
-		adev->suspend_complete = true;
+	else
 		return false;
-	}
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d30ad7d56def..dac223531cf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -900,13 +900,18 @@ static int soc21_common_suspend(void *handle)
 static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
 {
 	u32 sol_reg1, sol_reg2;
+	bool suspend_complete;
+
+	suspend_complete = !!(pm_suspend_global_flags &
+				PM_SUSPEND_FLAG_FW_RESUME);
 
 	/* Will reset for the following suspend abort cases.
 	 * 1) Only reset dGPU side.
 	 * 2) S3 suspend got aborted and TOS is active.
 	 */
 	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
-	    !adev->suspend_complete) {
+	    !suspend_complete) {
+
 		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
 		msleep(100);
 		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
-- 
2.34.1

