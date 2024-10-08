Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69199CF0423
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FE610E5C9;
	Tue,  8 Oct 2024 21:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ki2NNU2e";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537EF10E5C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k66uo1cbEBDJrvhRBGw3dPiGV+yoyFLuQzPXoOdKHLBUYeMGyNw73fJdZwP9TV/0FNr/BfI/U+drTvOyOVFj+CDVouTMyNGfgm+9/CIEf60BMqPFKag1CfNnjY4kYYoj8wgaL01bn0+iFcBPp5G3t7Fd25bxwmc7xHZjegXclxlk0x6QKT4MvUCUTU5oCwrGqfMl95D5LN5OKD1f6kqpSYMnSa6gKQgA/6//bQOUn/HzMx6EBh3jZAHhBmx6HyWalUUEvlsXIztcAlsSP1yWcDt+SDDzvHg8jhkMe1CswH3FrDWlcrzNez6xH6p1VW/raSazbD83vnB/qW3cjm4/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnT3R3C62x+a6VRa24eNfqfLTlV0DNfIhNY40yR6kaw=;
 b=jsJOhGm8/Hjg+S9JUI2mOAzhfhtBD0co61MFHyYPMjSL9oJOUV3WfGQVkdSbU8InLNHOG9XQNQfgyTIWfOjTUDHNhW1QhS8z7qwy7iNn2SvAgBIRmTfOagzyXbclm3S0iwmAR2M/s3pLrXEkEwImcnjRgr0DupkcAAP16loyhfh+VH12Cl2ua4ZHp/pNIxuK/2keZzS3xxPJQZj2CGwG8GPHwTDhXT987pgUOxDJ6SnYGkc9YZgZSq3/KpVe1N46G2XJC9geUcgirtCGI0Z4iVObTgmIlL1wq5ir+MlOOCSRIDp9W4JUS2ukIioXu/hNf7bHBXhbhygXnNxVhhMtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnT3R3C62x+a6VRa24eNfqfLTlV0DNfIhNY40yR6kaw=;
 b=ki2NNU2euqrfsFxkzZP04N11MMZ3gPYch9M0HfiK0PoUj9r7rC5LL0LbpD9VwsKQy7VSWwexY50zACInWnF0xOnf28NmF4EYyYb1CczziYhBQEHSJuMy8ozOi4l3AuXoGEzngqLDfA8qdTfjPdA/kd74Q4tstDhScKV5iXyWOrk=
Received: from CH0PR03CA0406.namprd03.prod.outlook.com (2603:10b6:610:11b::14)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 21:16:22 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::7f) by CH0PR03CA0406.outlook.office365.com
 (2603:10b6:610:11b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:21 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:19 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 04/32] drm/amd/pm: add inst to set_powergating_by_smu
Date: Tue, 8 Oct 2024 17:15:25 -0400
Message-ID: <20241008211553.36264-5-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008211553.36264-1-boyuan.zhang@amd.com>
References: <20241008211553.36264-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: ae87e4f6-878f-4888-2d98-08dce7de7582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHXjxEfxuyNlUQ7CxAQ1mjjCO81CFvNLMTVDX8os3klMyEPypU0T8e3DB6Ox?=
 =?us-ascii?Q?UghwVgVBCLmRvYFM8j6lzNyZAePyjCnoWvQWqSB2qvSVpjuSEdORTJZ9tlPv?=
 =?us-ascii?Q?X+5Er1xnFXy8OqWGG1enhHZR80tGeimk6emH+wawTKLbKJz+yJm2xaLYotV6?=
 =?us-ascii?Q?uzCuH21Rfpf6NEL51nXI0l0J5OdkSB+Kd8KLj3io1vrqcsG/Pj5DQ/E2SRM/?=
 =?us-ascii?Q?rwt3P3kH219Bi3bfrQZqMeY9/JePRveT3/r4zdA9h5nItDa7IkGY7hB+m7Dv?=
 =?us-ascii?Q?A7rG5OHrSE6gDJOkb3ctkmCuJDg/CigUBY1wKxdF/jE0ReKrcLn5CdYGJSAs?=
 =?us-ascii?Q?aYpL975UpeF+nnO48Tj729HLxvO/QOR3IXSYuZkLokQYdG+nsaxy6iKMVBJa?=
 =?us-ascii?Q?pQQBIFQZGSKc+w6IRIKk4JYmyo3yAszLilhb/JvwmG2ckQgG7GiqGGOxbnOl?=
 =?us-ascii?Q?1+V0uBz0QgTxeYD4K/K9niv+LnIAmSYsKKpRAxgahIKtcAb7xRCLu2Kr9Z0Q?=
 =?us-ascii?Q?Gvvvn0XnU0Hauulucx/If3t64jA6GXgB+yKFTZHXbJR9upji3CDhU0fRjLIG?=
 =?us-ascii?Q?4TJ3wKGvdGwvgu6iSsGP0xHt7BIT7ulILE/EqRv2EPQPCmSsCgPyy4sheRk1?=
 =?us-ascii?Q?ZmjQxaovlrXDHWDfDb2KnmMZIQ4TX72xRuDXe72HhSylyURip+YQXIGc/JI+?=
 =?us-ascii?Q?YBT4JM3kyIgSxPnCAg6vE9zFqSEbjOUDR2d1P4Cw4xdm/1uJXv+SPx5QUhL+?=
 =?us-ascii?Q?xSjVNYx7SIM7fcgTiKOrq+tHTKJmFuwc0awPIYexNYKbYIDRnfd0dOY/gQ3i?=
 =?us-ascii?Q?mbDIOgtigluRyzZpJrkZ2FVvBbLjN6DANBXhpk+ZhS7jFIE/v5Sz/c4XxPXT?=
 =?us-ascii?Q?xFf4bEA7WzQPLBPv3Lwt+EsLvLqae0T5nOs4GV4rMHrHOxq7C8sck0zy0c1I?=
 =?us-ascii?Q?aNV3wivEbwL8gCG7ezObTfZN1JgLwz34OivNegi69g0NZiUSNvhYLFT+yUvo?=
 =?us-ascii?Q?nLjT8bA1SduGdoInCDGxZVmN91y+koekIB45CdjBMJUl7fF4dGrbab6i3lDO?=
 =?us-ascii?Q?qvDZ8xb1ifFcbHyS4b3TKGRhfCVGWQhkZGhCOeIgUY3ktZ23fMgnnb7R6yYx?=
 =?us-ascii?Q?fQ9uKQ2G48KXeSvAJ5wJS3YJb5X6T+l27keTmUbEf41q/C1RGOw864vb/cNf?=
 =?us-ascii?Q?q6UCDi70gAVBxFyuCnBTXsdnI1DqHv29bDbN6vKHy5gYAsyTau59Aw9Qupf0?=
 =?us-ascii?Q?6/fKFxLcAD0iR390dOUI2POBCuw2aayTpDxovgq+guyVv2Oe4HeRE0cZv/Hn?=
 =?us-ascii?Q?+/1k8yAZEgmvbV+GED9w+wgOAyooZwl7vGSVtHjexB+5m+gLCaD+hgxtFkKO?=
 =?us-ascii?Q?YD6Q+Vs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:21.9051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae87e4f6-878f-4888-2d98-08dce7de7582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add an instance parameter to set_powergating_by_smu() function, and
re-write all amd_pm functions accordingly. Then use the instance to
call smu_dpm_set_vcn_enable().

v2: remove duplicated functions.

remove for-loop in smu_dpm_set_power_gate(), and temporarily move it to
to amdgpu_dpm_set_powergating_by_smu(), in order to keep the exact same
logic as before, until further separation in next patch.

v3: add instance number in error message.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  4 +++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 10 ++++++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |  4 +++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 14 ++++++--------
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2fa71f68205e..f24bc61df9a7 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -405,7 +405,9 @@ struct amd_pm_funcs {
 	int (*load_firmware)(void *handle);
 	int (*wait_for_fw_loading_complete)(void *handle);
 	int (*set_powergating_by_smu)(void *handle,
-				uint32_t block_type, bool gate);
+				uint32_t block_type,
+				bool gate,
+				int inst);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
 	int (*get_power_limit)(void *handle, uint32_t *limit,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..bcedbeec082f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -88,7 +88,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
 	case AMD_IP_BLOCK_TYPE_GFX:
-	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
 	case AMD_IP_BLOCK_TYPE_JPEG:
 	case AMD_IP_BLOCK_TYPE_GMC:
@@ -96,7 +95,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_VPE:
 		if (pp_funcs && pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
-				(adev)->powerplay.pp_handle, block_type, gate));
+				(adev)->powerplay.pp_handle, block_type, gate, 0));
+		break;
+	case AMD_IP_BLOCK_TYPE_VCN:
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+				ret = (pp_funcs->set_powergating_by_smu(
+					(adev)->powerplay.pp_handle, block_type, gate, i));
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 2cd6cb991f29..af7da780b58b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3287,7 +3287,9 @@ static int kv_dpm_read_sensor(void *handle, int idx,
 }
 
 static int kv_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index f193c77cc141..de5ee1c5503f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1241,7 +1241,9 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
 }
 
 static int pp_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 639bc6d97b27..115931d1c461 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -353,10 +353,10 @@ static int smu_set_mall_enable(struct smu_context *smu)
  */
 static int smu_dpm_set_power_gate(void *handle,
 				  uint32_t block_type,
-				  bool gate)
+				  bool gate,
+				  int inst)
 {
 	struct smu_context *smu = handle;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
@@ -373,12 +373,10 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			ret = smu_dpm_set_vcn_enable(smu, !gate, i);
-			if (ret)
-				dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
-					gate ? "gate" : "ungate", i);
-		}
+		ret = smu_dpm_set_vcn_enable(smu, !gate, inst);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
+				gate ? "gate" : "ungate", inst);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
-- 
2.34.1

