Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3258D7234F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1C010EA8A;
	Fri, 23 Jan 2026 10:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L1aLiVs9";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5D210EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qisf7gGkuCGEHTMWf/+GgPVMSjOZxJXBCRHYxj/Na0un4KMEaj4fja9dsXLfOTN3kW05EOZYknc6Slf47RrzGzds3shvjzJsLn4/gAs2mzfF0fhJOH37F0f8S/KxJ5TGGKTCpY9sVMWHdhacjJ0z598VtumHbvGXS+9ST9vE4FgvKuk7RTrhnWUOzwm/J+x4jtu1I4vme05AyjXBT9N0J5DoalwphuS1ibK+qdcLmBR1EkfKlkgOZTuaFhvxXl3mviqDa6hU/4/qp3qmhkWvJPQM9UfEIpf28LTtSGO3ABFOuqYlg2SESJxSuUstktjQhHmjRjFD6Qw0FjkND4oZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bm/ALbInDIHmMpABlsscTc5lhMSq4wNqHraWnATLU4=;
 b=nqW4SU+X43ZuGjGaUxwYDi+qZAU+SxnCdBIe4dovh7wNzHFXc2Ym130hHH1yib8Xb+WQV8z4sGyyzwmm3pzW8WaiqN3216SXTWLS7rcGV0MJxyb7hq07LLitFZnZ2wK7sW5hUY8M+MEPZYvrR0zA6p64DCx101+FW4BNidH0SLx2dvl9aE+zPi6dCVbAw5IYdQcNpMmGVvjTZSA4l7mgZuzXHGIcZJJIZNuKZi5eV/K+CGFV1/s5wYsCkJsFMLUzp2AgizIqN6G5zLzbs+yCPbf0NHWMmEuKQsDCDLiYZG8lktwhETka4doEqZK8bRUWb1YL2kB+1hK3HOWB2Uv9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bm/ALbInDIHmMpABlsscTc5lhMSq4wNqHraWnATLU4=;
 b=L1aLiVs97teSKjQ+rxd7cDjj+JkYQHBHM89rI68P5CJT9fVmKrsZ0OGSJw5zRDoHVexiZCD9A4TKvNmzfXg9IGt78xEBXepSGNzV4h7GXRR8JDkDZgEWJ2N+ciULwPo3XX+50qokqQI26IRHvLRUNF6jvAaiB7enCJyH15vhaIo=
Received: from MN2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:23a::6)
 by BL4PR12MB9506.namprd12.prod.outlook.com (2603:10b6:208:590::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:08:32 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::d) by MN2PR03CA0001.outlook.office365.com
 (2603:10b6:208:23a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:08:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:08:31 -0600
Received: from kenneth-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:08:25 -0800
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <KevinYang.Wang@amd.com>, <Alexander.Deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: send unload command to smu during modprobe
 -r amdgpu
Date: Fri, 23 Jan 2026 18:08:08 +0800
Message-ID: <20260123100808.1992-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123100808.1992-1-kenneth.feng@amd.com>
References: <20260123100808.1992-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|BL4PR12MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5a8355-f105-4c22-e8c5-08de5a675cf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cD2kJVCjbbvul+eciK4AQAtLfpVqM2dCPd0dkGlAX5oJ185E6/hkHcrLPg69?=
 =?us-ascii?Q?bP/W7kWtKWASyVustw5hEM+LEeAoiNSFuPdzJsKKoGPpxdGM6hLQMfM9YLKP?=
 =?us-ascii?Q?phvfcePxLF+smp+699CPM/M6o4s+u887W5JyNGslgFVWYarnScp3bZ1SWISV?=
 =?us-ascii?Q?/FX/I9WVWfapCpF2dqq8Zgw4bjU/TxTwIayHSJVZOCi9sp0UQK/rbQR5n+uY?=
 =?us-ascii?Q?6UsY/665gOF3/RhCjILLUFRh6PHEY7Ko6eclt3i2FDJTZyI0EGFmGwaRRoMR?=
 =?us-ascii?Q?hRWxUeefRd1JaN33j7osFgJT0IuV7ajsPd03fWWWxRF7pwmQQpKMB7CpzosM?=
 =?us-ascii?Q?fzylK0XJAob6Y/6d1oIlElKFdoqrKk+dHRfPut4dqgA6BnBenGL21Xg+C15D?=
 =?us-ascii?Q?oBKIKGinhEpYYEdH7BlBdFiPgsotDX8ZkyHdJI4tP5vdAXyzrDulUbrL0FCc?=
 =?us-ascii?Q?oAoIJV0lDXIwuY2j6jyRkUapnyZ4BufokbEHICUWi/kqLOfUmKFwH6XMHMQ8?=
 =?us-ascii?Q?FDW4tcBfNvXe2aEQ6sweAkQlMeg/rlfAVMpJ4w2ovNWLPy8NGnhhlMY76mvV?=
 =?us-ascii?Q?S6nmKtRCeI+82NE3YWfmZpJNYKhTZcXa53FimOxijdOWm0VY3XfBL0bintNZ?=
 =?us-ascii?Q?w9qUYdYu9eQDQi3ZyjgB1PJlnCrg5UK0x+o6uH6+knUdS8/3Hz0IP7/2MqiQ?=
 =?us-ascii?Q?kQzQy0nmes7oXGfyjTH3oa7eTwPz/dNjOV17/tkBrn3FDhgs9aK03VPMXu7d?=
 =?us-ascii?Q?JuYc1U1CWYQZzetu7br4eg5YzUWGVajX3zvoz67r8l0c+PRRdAoxBh5hF/ob?=
 =?us-ascii?Q?vHqoFcBgZLPt+JsvsB/AwW9RHgr34+kILY6PkB6lxcHIIeOYw6cFBahJx0Lg?=
 =?us-ascii?Q?Xw0f0Y8E5pnEGlz6MtHSVOWOplfo5LfK26EDQKKOr4hHYGdxLN7PZNRPGtek?=
 =?us-ascii?Q?2FoRKvSEh4AuoofS9KYZ0vojQREDA2S6wkfofJnDsaAvuHqajB22FxJ32CHf?=
 =?us-ascii?Q?iI2iTGNImQKrjGZCCyZpRPqqmrSeQ8U45sXfFj2uSPA/54/QXa8O7gnwpqhx?=
 =?us-ascii?Q?QP6mKrECTskia2rNxfRNg0mdxKRyuolNNdsfed7VNXOJ6k/Zo903fXg+QGzm?=
 =?us-ascii?Q?m4tZEDy/F4L758tqyCgn7cD0ACQCVHbIffVEK/w50iif09XF1N8NueirJ7jM?=
 =?us-ascii?Q?LZL0fcSSH9LTQMBxdSxsSKGWFdPRd+92faQVcx5VmSFpCNzrpismT9tLbIbd?=
 =?us-ascii?Q?LuyJBJeujGVRTpuDbh6bIsDMP5/5Vhd+cWl1mXKkKlEnWamIFwxO2ME7TU0t?=
 =?us-ascii?Q?/17KGGplBdKECwGPkrPD5ttboCDpxyn7Mo9W0GzE1/ejp51uovTvFV5cq4jU?=
 =?us-ascii?Q?Frbqkv+u2zJ6BlVH5WK1BDfHjXxLxHuiThiaRz79ITT6bVSSIhUo9fhJ3MZR?=
 =?us-ascii?Q?EFf6CNsiVvhIIle52qaTwwpgTkbCKOlt8ATuwohJhzD+R8tQx5joLTXJEimv?=
 =?us-ascii?Q?AlNbz4NZ6W9IQx5/jerRPcwlSJx1RJi87pS3xi62tgFVtXeSB3nshSlMWB5Z?=
 =?us-ascii?Q?OFuIG3AHIi+7vZ+imFIv36oyhIMAiFyTFTZxTCi5Q4wp9HeK55ieX7Cvbo/5?=
 =?us-ascii?Q?2sz4Y8VwersKk3CiecX8IgJvxUK6rOvR7hIBHAzXaKbECUesWOMCjYn3bdPS?=
 =?us-ascii?Q?E5yq2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:08:32.0249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5a8355-f105-4c22-e8c5-08de5a675cf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9506
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

Send unload command to smu during modprobe -r amdgpu for smu 13/14.
1. This can fix the high voltage/temperatue issue after driver is unloaded.
2. Reloading driver could fail but with the debug port based mode1 reset
during driver is reloaded, it is good and safe.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 3 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 7 +++----
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h        | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 8 +-------
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b2deb6a74eb2..be115c3df370 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4657,9 +4657,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			dev_info(adev->dev, "Pending hive reset.\n");
 			amdgpu_set_init_level(adev,
 					      AMDGPU_INIT_LEVEL_MINIMAL_XGMI);
-		} else if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
-				   !amdgpu_device_has_display_hardware(adev)) {
-					r = psp_gpu_reset(adev);
 		} else {
 				tmp = amdgpu_reset_method;
 				/* It should do a default reset when loading or reloading the driver,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 6b6b05e8f736..666d2bdd08d9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -820,7 +820,7 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	smu->smu_baco.state = SMU_BACO_STATE_NONE;
+	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 	smu->smu_baco.maco_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
@@ -2134,9 +2134,8 @@ static int smu_reset_mp1_state(struct smu_context *smu)
 	int ret = 0;
 
 	if ((!adev->in_runpm) && (!adev->in_suspend) &&
-		(!amdgpu_in_reset(adev)) && amdgpu_ip_version(adev, MP1_HWIP, 0) ==
-									IP_VERSION(13, 0, 10) &&
-		!amdgpu_device_has_display_hardware(adev))
+		(!amdgpu_in_reset(adev)) && !smu->is_apu &&
+			amdgpu_ip_version(adev, MP1_HWIP, 0) >= IP_VERSION(13, 0, 0))
 		ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 1def04826f10..6bd104b7187f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -508,7 +508,6 @@ enum smu_reset_mode {
 enum smu_baco_state {
 	SMU_BACO_STATE_ENTER = 0,
 	SMU_BACO_STATE_EXIT,
-	SMU_BACO_STATE_NONE,
 };
 
 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index d216db3b804b..5a871c9bf43c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2770,13 +2770,7 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-											  SMU_MSG_PrepareMp1ForUnload,
-											  0x55, NULL);
-
-		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
-			ret = smu_v13_0_disable_pmfw_state(smu);
-
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
 		break;
 	default:
 		/* Ignore others */
-- 
2.34.1

